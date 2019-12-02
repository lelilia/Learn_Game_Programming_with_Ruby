require 'gosu'
require_relative 'player'
require_relative 'friend'
require_relative 'credit'
require_relative 'heart'

class MoreHearts < Gosu::Window
	WIDTH = 800
	HEIGHT = 600
	FRIEND_FREQUENCY = 0.01
	MAX_FRIENDS = 10
	
	def initialize
		super(WIDTH, HEIGHT)
		self.caption = "More Hearts than Bullets"
		@background_image = Gosu::Image.new('images/start_screen.png')
		@scene = :start
	end

	def initialize_game
		@scene = :game 
		@level = 1
		@font = Gosu::Font.new(24)
		@player = Player.new(self)
		@hearts = []
		@friends = []
		@friends_have_left = {sad: 0, happy: 0}
	end

	def initialize_end
		@scene = :end
		@message = "Oh no! #{@friends_have_left[:sad]} friends of you left while still being sad."
		@message2 = "But you cheered #{@friends_have_left[:happy]} friends up! So great!"
		@bottom_message = "Press P to play again, or Q to quit."
		@message_font = Gosu::Font.new(28)
		@credits = []
		y = 500
		File.open('credit.txt').each do |line|
			@credits.push(Credit.new(self, line.chomp, 100, y))
			y += 30
		end
	end

	def update
		case @scene
		when :game
			update_game
		when :end
			update_end
		end
	end

	def update_game
		@player.turn_left if button_down?(Gosu::KbLeft)
		@player.turn_right if button_down?(Gosu::KbRight)
		@player.accelerate if button_down?(Gosu::KbUp)
		@player.backwards if button_down?(Gosu::KbDown)
		@player.move
		# create new friends
		if rand < FRIEND_FREQUENCY
			@friends.push Friend.new(self, (rand(WIDTH) - 64) + 32, 0, rand(140) + 110, 4, :sad)
		end
		# move the hearts
		@hearts.each do |heart|
			heart.move
		end
		# move the friends
		@friends.each do |friend|
			friend.move
		end
		# check for friends receiving hearts
		@friends.dup.each do |friend|
			@hearts.dup.each do |heart|
				distance = Gosu::distance(friend.x, friend.y, heart.x, heart.y)
				if distance < friend.radius + heart.radius
					friend.set_mood(:happy)
					@hearts.delete heart
				end
			end
		end
		# remove hearts that are no longer on screen
		@hearts.dup.each do |heart|
			@hearts.delete heart unless heart.onscreen?
		end
		# remove friends that are no longer on screen
		@friends.dup.each do |friend|
			if not friend.onscreen?
				@friends.delete friend
				@friends_have_left[friend.mood] += 1
			end
		end
		# check for collisions of friends
		@friends.dup.each do |friend1|
			@friends.dup.each do |friend2|
				distance = Gosu::distance(friend1.x, friend1.y, friend2.x, friend2.y)
				if distance < friend1.radius + friend2.radius and friend1 != friend2
					phi = (Gosu::angle(friend1.x, friend1.y, friend2.x, friend2.y) + 90)
					x1  = friend1.x - 0.1 * friend1.radius * Gosu::offset_x(phi - 90, 1)
					y1  = friend1.y - 0.1 * friend1.radius * Gosu::offset_y(phi - 90, 1)
					x2  = friend2.x + 0.1 * friend2.radius * Gosu::offset_x(phi - 90, 1)
					y2  = friend2.y + 0.1 * friend2.radius * Gosu::offset_y(phi - 90, 1)
					v1x = friend1.speed * Gosu::offset_y(friend2.angle - phi, 1) * Gosu::offset_y(phi, 1) + friend1.speed * Gosu::offset_x(friend2.angle - phi, 1) * Gosu::offset_y(phi + 90, 1)
					v1y = friend1.speed * Gosu::offset_y(friend2.angle - phi, 1) * Gosu::offset_x(phi, 1) + friend1.speed * Gosu::offset_x(friend2.angle - phi, 1) * Gosu::offset_x(phi + 90, 1)
					v2x = friend2.speed * Gosu::offset_y(friend1.angle - phi, 1) * Gosu::offset_y(phi, 1) + friend2.speed * Gosu::offset_x(friend1.angle - phi, 1) * Gosu::offset_y(phi + 90, 1)
					v2y = friend2.speed * Gosu::offset_y(friend1.angle - phi, 1) * Gosu::offset_x(phi, 1) + friend2.speed * Gosu::offset_x(friend1.angle - phi, 1) * Gosu::offset_x(phi + 90, 1)
					friend1.set_velocity(x1, y1, v1x, v1y)
					friend2.set_velocity(x2, y2, v2x, v2y)
				end
			end
		end
		# initialize the end scene if the maximum number of friends left sad
		initialize_end if @friends_have_left[:sad] > MAX_FRIENDS
	end

	def update_end
		@credits.each do |credit|
			credit.move
		end
		if @credits.last.y < 100
			@credits.each do |credit|
				credit.reset
			end
		end
	end

	def draw
		case @scene
		when :start
			draw_start
		when :game
			draw_game
		when :end
			draw_end
		end
	end

	def draw_start
		@background_image.draw(0,0,0)
	end

	def draw_game
		@player.draw
		@hearts.each do |heart|
			heart.draw
		end
		@friends.each do |friend|
			friend.draw
		end
	end

	def draw_end
		clip_to(50, 140, 700, 360) do
			@credits.each do |credit|
				credit.draw
			end
		end
		draw_line(0,140,Gosu::Color.argb(0xffff69b4), WIDTH, 140, Gosu::Color.argb(0xffff69b4))
		@message_font.draw_text(@message, 40, 40, 1, 1, 1, Gosu::Color.argb(0xffeb2daf))
		@message_font.draw_text(@message2, 40, 75, 1, 1, 1, Gosu::Color.argb(0xffeb2daf))
		draw_line(0,500, Gosu::Color.argb(0xffff69b4), WIDTH, 500, Gosu::Color.argb(0xffff69b4))
		@message_font.draw_text(@bottom_message, 180, 540, 1, 1, 1, Gosu::Color.argb(0xffae2deb))
	end

	def button_down(id)
		case @scene
		when :start
			button_down_start(id)
		when :game
			button_down_game(id)
		when :end
			button_down_end(id)
		end
	end

	def button_down_start(id)
		if id == Gosu::KbEscape
			close
		end
		initialize_game
	end

	def button_down_game(id)
		if id == Gosu::KbEscape
			close
		end
		if id == Gosu::KbSpace
			@hearts.push Heart.new(self, @player.x, @player.y, @player.angle)
		end
	end

	def button_down_end(id)
		if id == Gosu::KbP
			initialize_game
		elsif id == Gosu::KbQ or id == Gosu::KbEscape
			close
		end
	end
end

window = MoreHearts.new
window.show
