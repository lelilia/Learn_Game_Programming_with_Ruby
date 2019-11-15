require_relative 'square'

class Game
	def initialize(window)
		@window = window
		@font = Gosu::Font.new(72)
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



	def fill_random_empty_square
		empty_squares = []
		@squares.each do |square|
			if square.val == 0
				empty_squares.push square.row*4+square.col 
			end
		end
		if empty_squares == []
			lose?
		end
		@squares[empty_squares.sample].set(2)
	end

	def lose?
		@values = []
		@squares.each do |square|
			@values.push square.val
		end
		(0..3).each do |row|
			(0..2). each do |column|
				if @values[row*4 + column] == @values[row*4 + column + 1]						
					break
				end
			end
		end
		(0..3).each do |column|
			(0..2). each do |row|
				if @values[row*4 + column] == @values[(row+1)*4 + column]
					break
				end
			end
		end
		@lose = true
	end

	def ignore_me
		(0..3).each do |row|
			(0..2).each do |column|
				if get_square(row, column).val == get_square(row, column+1).val
					return false
				end
			end
		end
		(0..3).each do |column|
			(0..2).each do |row|
				if get_square(row, column).val == get_square(row + 1, column).val
					return false
				end
			end
		end
	end



	def get_square(col, row)
		return @squares[row*4+col]
	end

	def move(direction)
		did_something_happen = false
		case direction
		when :up, :down
			(0..3).each do |col|
				arr = []
				(0..3).each do |row|
					arr.push get_square(col, row).val
				end
				if direction == :down
					arr = arr.reverse
				end
				old_arr = arr.clone
				arr = handle_stack(arr)
				if arr != old_arr
					did_something_happen = true
				end
				(0..3).each do |row|
					square = get_square(col, row)
					if direction == :up
						square.set(arr.shift)
					else
						square.set(arr.pop)
					end
				end
			end
		when :left, :right
			(0..3).each do |row|
				arr = []
				(0..3).each do |col|
					arr.push get_square(col, row).val
				end
				if direction == :right
					arr = arr.reverse
				end
				old_arr = arr.clone
				arr = handle_stack(arr)
				if arr != old_arr
					did_something_happen = true 
				end
				(0..3).each do |col|
					square = get_square(col, row)
					if direction == :left
						square.set(arr.shift)
					else
						square.set(arr.pop)
					end
				end
			end
		end
		if did_something_happen == true
			fill_random_empty_square
		end
	end


	def handle_stack(arr)
		for i in 0..arr.length - 1
			if arr[i] == 0
				for j in i+1..arr.length-1 do
			      	if arr[j] != 0
        				arr[i],arr[j] = arr[j], arr[i]
        				break
      				end
    			end
  			end
  			if arr[i] != 0
    			for j in i+1..arr.length-1 do
      				if arr[j]!= arr[i] and arr[j] != 0
        				break
      				elsif arr[j] == arr[i]
        				arr[i] *= 2
        				## check for win state
        				if arr[i] == 2048
        					@win = true
        				end
        				arr[j] = 0
        				break
      				end
    			end
  			end
		end
		return arr
	end

	def draw
		@squares.each do |square|
			square.draw
		end
		if @win == true
			c = Gosu::Color.argb(0x33000000)
			@window.draw_quad(0, 0, c, 440, 0, c, 440, 440, c, 0, 440, c, 4)
			@font.draw('You win!', 100, 184, 5)
		end
		if @lose == true
			c = Gosu::Color.argb(0x33000000)
			@window.draw_quad(0, 0, c, 440, 0, c, 440, 440, c, 0, 440, c, 4)
			@font.draw('You lose!', 100, 184, 5)
			@font.draw(@values, 20, 184, 5)
		end
	end
	
							
					
				

end

