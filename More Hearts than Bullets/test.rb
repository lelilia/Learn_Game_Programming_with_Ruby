require 'gosu'
require_relative 'friend'

class MoreHearts < Gosu::Window
	WIDTH = 800
	HEIGHT = 600
	FRIEND_FREQUENCY = 0.01
	MAX_FRIENDS = 10
	
	def initialize
		super(WIDTH, HEIGHT)
		self.caption = "More Hearts than Bullets"
		@background_image = Gosu::Image.new('images/start_screen.png')
		@font = Gosu::Font.new(24)
		@friends = []
		@friends_have_left = {sad: 0, happy: 0}
			
		@friends.push Friend.new(self, 0, 300, 90, 4, :sad)
		@friends.push Friend.new(self, 800, 300,  270, 4, :sad)
		
	end



	def update

		if rand < FRIEND_FREQUENCY
			@friends.push Friend.new(self, 0, 300, 90, 4, :sad)
			@friends.push Friend.new(self, 800, 300,  270, 4, :sad)
		end

		# move the friends
		@friends.each do |friend|
			friend.move
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
					# phi = (Gosu::angle(friend1.x, friend1.y, friend2.x, friend2.y) + 90)
					# x1  = friend1.x - 4 * friend1.radius * Gosu::offset_x(phi - 90, 1)
					# y1  = friend1.y - 4 * friend1.radius * Gosu::offset_y(phi - 90, 1)
					# x2  = friend2.x + 4 * friend2.radius * Gosu::offset_x(phi - 90, 1)
					# y2  = friend2.y + 4 * friend2.radius * Gosu::offset_y(phi - 90, 1)
					# # x1 = 100
					# # y1 = 300
					# # x2 = 700
					# # y2 = 300
					# # v1x = Gosu::offset_x(phi, 4)
					# # v1y = Gosu::offset_y(phi, 4)
					# # v2x = Gosu::offset_x(phi, 4)
					# # v2y = Gosu::offset_y(phi, 4)
					# v1x = friend1.speed * Gosu::offset_y(friend2.angle - phi, 1) * Gosu::offset_y(phi, 1) + friend1.speed * Gosu::offset_x(friend2.angle - phi, 1) * Gosu::offset_y(phi + 90, 1)
					# v1y = friend1.speed * Gosu::offset_y(friend2.angle - phi, 1) * Gosu::offset_x(phi, 1) + friend1.speed * Gosu::offset_x(friend2.angle - phi, 1) * Gosu::offset_x(phi + 90, 1)
					# v2x = friend2.speed * Gosu::offset_y(friend1.angle - phi, 1) * Gosu::offset_y(phi, 1) + friend2.speed * Gosu::offset_x(friend1.angle - phi, 1) * Gosu::offset_y(phi + 90, 1)
					# v2y = friend2.speed * Gosu::offset_y(friend1.angle - phi, 1) * Gosu::offset_x(phi, 1) + friend2.speed * Gosu::offset_x(friend1.angle - phi, 1) * Gosu::offset_x(phi + 90, 1)
					# friend1.set_velocity(x1, y1, v1x, v1y)
					# friend2.set_velocity(x2, y2, v2x, v2y)
				end
			end
		end
		# initialize the end scene if the maximum number of friends left sad
		
	end


	def draw
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

	end


end

window = MoreHearts.new
window.show
