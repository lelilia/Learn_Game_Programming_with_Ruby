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
		@squares = []

		@squares.push Square.new(self, 0,0,1)
		@squares.push Square.new(self, 1,0,2)
		@squares.push Square.new(self, 2,0,3)
		@squares.push Square.new(self, 3,0,5)
		@squares.push Square.new(self, 0,1,8)
		@squares.push Square.new(self, 1,1,13)
		@squares.push Square.new(self, 2,1,21)
		@squares.push Square.new(self, 3,1,34)
		@squares.push Square.new(self, 0,2,55)
		@squares.push Square.new(self, 1,2,89)
		@squares.push Square.new(self, 2,2,144)
		@squares.push Square.new(self, 3,2,233)
		@squares.push Square.new(self, 0,3,377)
		@squares.push Square.new(self, 1,3,610)
		@squares.push Square.new(self, 2,3,987)
		@squares.push Square.new(self, 3,3,1597)
	end

	def draw
		@squares.each do |s|
			s.draw
		end
	
				
				
			
	end
end

window = Game2048.new
window.show