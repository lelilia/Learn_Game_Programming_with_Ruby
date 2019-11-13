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
		fill_random_empty_square
		fill_random_empty_square

	end

	def draw
		@squares.each do |square|
			square.draw
		end
		#game over?
	end

	def fill_random_empty_square
		empty_squares = []
		@squares.each do |square|
			if square.val == 0
				empty_squares.push square.row*4+square.col 
			end
		end
		@squares[empty_squares.sample].set(2)
	end

	def get_square(col, row)
		return @squares[row*4+col]
	end

	def move_up
		@squares.each do |square|
			if square.val !=0
				#check if there is space above
				#move it there
			end 
		end
	end

end

