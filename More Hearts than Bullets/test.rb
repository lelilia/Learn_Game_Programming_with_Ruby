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
		@scene = :game 
		@level = 1
		@font = Gosu::Font.new(24)
		@player = Player.new(self)
		@hearts = []
		@friends = []
		@friends_have_left = {sad: 0, happy: 0}
			
		@friends.push Friend.new(self, 0, 300, 90, 4, :sad)
		@friends.push Friend.new(self, 800, 300,  270, 4, :sad)
		
	end



	def update
		@player.turn_left if button_down?(Gosu::KbLeft)
		@player.turn_right if button_down?(Gosu::KbRight)
		@player.accelerate if button_down?(Gosu::KbUp)
		@player.backwards if button_down?(Gosu::KbDown)
		@player.move

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
					x1  = friend1.x + 4 * friend1.radius * Gosu::offset_x(phi - 90, 1)
					y1  = friend1.y + 4 * friend1.radius * Gosu::offset_y(phi - 90, 1)
					x2  = friend2.x + 4 * friend2.radius * Gosu::offset_x(phi - 90, 1)
					y2  = friend2.y + 4 * friend2.radius * Gosu::offset_y(phi - 90, 1)
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
		
	end


	def draw
		@player.draw
		@hearts.each do |heart|
			heart.draw
		end
		@friends.each do |friend|
			friend.draw
		end
	end



	def button_down(id)
		if id == Gosu::KbEscape
			close
		end
		if id == Gosu::KbR
			initialize
		end
		if id == Gosu::KbSpace
			@hearts.push Heart.new(self, @player.x, @player.y, @player.angle)
		end
	end


end

window = MoreHearts.new
window.show
