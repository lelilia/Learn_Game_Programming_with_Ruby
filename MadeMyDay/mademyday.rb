require 'gosu'
require_relative 'player'
require_relative 'friend'
require_relative 'happyfriend'
require_relative 'heart'


class MadeMyDay < Gosu::Window
	WIDTH = 800
	HEIGHT = 600
	FRIEND_FREQUENCY = 0.01
	MAX_FRIENDS = 100

	def initialize
		super(WIDTH, HEIGHT)
		self.caption = 'Made My Day'
		#@background_image = Gosu::Image.new('images/start_screen.png')
		@scene = :start
		#@start_music = Gosu::Song.new('sounds/SOMETHING')
		#@start_music.play(true)

		## initialize_game
		@player = Player.new(self)
		@friends = []
		@hearts = []
		@happyfriends = []
	end

	def update
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
			@friends.delete friend if friend.y < - 3 * friend.radius
		end
		@happyfriends.dup.each do |happyfriend|
			@happyfriends.delete happyfriend if happyfriend.y > HEIGHT + happyfriend.radius 
		end
	end

	def draw
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

	def button_down(id)
		if id == Gosu::KbEscape
			close
		end
		if id == Gosu::KbSpace
			@hearts.push Heart.new(self, @player.x, @player.y, @player.angle)
		end
	end

end

window = MadeMyDay.new
window.show