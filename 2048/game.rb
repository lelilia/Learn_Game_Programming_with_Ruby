require_relative 'square'

class Game
	def initialize(window)
		@window = window
		@squares = []
		(0..3).each do |row|
			(0..3).each do |col|
				index = row*4 + col
				@squares.push Square.new(@window, col, row, 0)
			end
		end

	end

	def draw
		@squares.each do |square|
			square.draw
		end
		#game over?
	end

	def fill_random_empty_square

	end

end

