require 'gosu'
require_relative 'player'
require_relative 'friend'
require_relative 'happyfriend'
require_relative 'heart'
require_relative 'credit'


class MadeMyDay < Gosu::Window
	WIDTH = 800
	HEIGHT = 600
	FRIEND_FREQUENCY = 0.01
	MAX_FRIENDS = 1

	def initialize
		super(WIDTH, HEIGHT)
		self.caption = 'Made My Day'
		@background_image = Gosu::Image.new('images/start_screen.png')
		@scene = :start
		#@start_music = Gosu::Song.new('sounds/SOMETHING')
		#@start_music.play(true)
	end

	def initialize_game
		@scene = :game
		@level = :level1
		@font = Gosu::Font.new(24)
		@player = Player.new(self)
		@friends = []
		@hearts = []
		@happyfriends = []
		@happyfriends_left = 0
		@friends_left = 0
	end

	def initialize_end
		@message = "Oh no! #{@friends_left} friends of you left while still being sad."
		@message2 = "But you cheered #{@happyfriends_left} friends up! So great!"
		if @happyfriends_left == 0
			@message2 = "Oh no you did not cheer any of your friends up... are you ok?"
		end
		@bottom_message = "Press P to play again, or Q to quit."
		@message_font = Gosu::Font.new(28)
		@credits = []
		y = 500
		File.open('credit.txt').each do |line|
			@credits.push(Credit.new(self, line.chomp, 100, y))
			y += 30
		end
		@scene = :end
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

		if rand < FRIEND_FREQUENCY
			@friends.push Friend.new(self)
		end
		@friends.each do |friend|
			friend.move
		end
		@happyfriends.each do |happyfriend|
			happyfriend.move
		end
		@hearts.each do |heart|
			heart.move
		end
		@friends.dup.each do |friend|
			@hearts.dup.each do |heart|
				distance = Gosu::distance(friend.x, friend.y, heart.x, heart.y)
				if distance < friend.radius + heart.radius
					@friends.delete friend
					@hearts.delete heart
					@happyfriends.push HappyFriend.new(self, friend.x, friend.y)
				end
			end
		end
		@hearts.dup.each do |heart|
			@hearts.delete heart unless heart.onscreen?
		end
		@friends.dup.each do |friend|
			 if friend.y < - 4 * friend.radius
				@friends.delete friend
				@friends_left += 1
			end
		end
		initialize_end if @friends_left > MAX_FRIENDS
		@happyfriends.dup.each do |happyfriend|
			if happyfriend.y > HEIGHT + happyfriend.radius 
				@happyfriends.delete happyfriend 
				@happyfriends_left += 1
			end
		end
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
		#@font.draw_text("#{@friends_left}", 100, 100, 2)
		@player.draw
		@friends.each do |friend|
			friend.draw
		end
		@hearts.each do |heart|
			heart.draw
		end
		@happyfriends.each do |happyfriend|
			happyfriend.draw
		end
	end

	def draw_end
		clip_to(50, 140, 700, 360) do 
			@credits.each do |credit|
				credit.draw
			end
		end
		draw_line(0,140,Gosu::Color::RED, WIDTH, 140, Gosu::Color::RED)
		@message_font.draw_text(@message, 40, 40, 1, 1, 1, Gosu::Color::FUCHSIA)
		@message_font.draw_text(@message2, 40, 75, 1, 1, 1, Gosu::Color::FUCHSIA)
		draw_line(0,500,Gosu::Color::RED, WIDTH, 500, Gosu::Color::RED)
		@message_font.draw_text(@bottom_message, 180, 540, 1, 1, 1, Gosu::Color::AQUA)
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

window = MadeMyDay.new
window.show