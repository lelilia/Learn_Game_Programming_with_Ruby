require 'gosu'
require_relative 'game'

class Game2048 < Gosu::Window
	SQUARE_SIZE = 100
	SQUARE_BORDER = 4
	NUMBER_OF_SQUARES = 4
	WINDOW_SIZE = (SQUARE_SIZE + SQUARE_BORDER * 2) * NUMBER_OF_SQUARES + 2 * SQUARE_BORDER

	def initialize
		super(WINDOW_SIZE, WINDOW_SIZE)
		self.caption = 'Finobannci'
		@game = Game.new(self)
	end

	def draw
		@game.draw
	end

	def button_down(id)
		if id == Gosu::KbR
			@game = Game.new(self)
		elsif id == Gosu::KbUp
			#move up
			@win = false
			@game.move(:up)
		elsif id == Gosu::KbDown
			#move down
			@win = false
			@game.move(:down)
		elsif id == Gosu::KbLeft
			#move left
			@win = false
			@game.move(:left)
		elsif id == Gosu::KbRight
			#move right
			@win = false
			@game.move(:right)
		elsif id == Gosu::KbEscape
			close
			
		end
				
				
			
	end
end

window = Game2048.new
window.show