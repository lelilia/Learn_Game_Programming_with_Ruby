require 'gosu'
require_relative 'player'

class MadeMyDay < Gosu::Window
	WIDTH = 800
	HEIGHT = 600
	FRIEND_FREQUENCY = 0.05
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
	end

	def update
		@player.turn_left if button_down?(Gosu::KbLeft)
		@player.turn_right if button_down?(Gosu::KbRight)
		@player.accelerate if button_down?(Gosu::KbUp)
		#@player.backwards if button_down?(Gosu::KbDown)
		@player.move
	end

	def draw
		@player.draw
	end

end

window = MadeMyDay.new
window.show