require_relative 'square'

class Game
	def initialize(window)
		@window = window
		@font = Gosu::Font.new(72)
		@already_won = false
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
		if @win == true
			c = Gosu::Color.argb(0x33000000)
			@window.draw_quad(0, 0, c, 440, 0, c, 440, 440, c, 0, 440, c, 4)
			@font.draw('You win!', 100, 184, 5)
		end
		if is_the_game_lost?
			c = Gosu::Color.argb(0x33000000)
			@window.draw_quad(0, 0, c, 440, 0, c, 440, 440, c, 0, 440, c, 4)
			@font.draw('You lose!', 100, 184, 5)
			@font.draw(@values, 20, 184, 5)
		end
	end

	def find_empty_squares
		empty_squares = []
		@squares.each do |square|
			if square.val == 0
				empty_squares.push square.row*4+square.col 
			end
		end
		return empty_squares
	end

	def fill_random_empty_square
		empty_squares = find_empty_squares
		
		random_new_value = rand
		if random_new_value > 0.99
			random_new_value = 8
		elsif random_new_value > 0.95
			random_new_value = 4
		else
			random_new_value = 2
		end	
		@squares[empty_squares.sample].set(random_new_value)
	end

	def is_the_game_lost?
		if find_empty_squares != []
			return false
		else
			array_of_values = []
			@squares.each do |square|
				array_of_values.push square.val
			end
			(0..3).each do |row|
				(0..2).each do |col|
					if array_of_values[row * 4 + col] == array_of_values[row * 4 + col + 1] or array_of_values[col * 4 + row] == array_of_values[(col+1)*4 + row]
						return false
					end
				end
			end
			return true
		end

	end

	def get_square(col, row)
		return @squares[row*4+col]
	end

	def move(direction)
		@win = false
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
        				if arr[i] == 2048 and @already_won == false
        					@win = true
        					@already_won = true
        				end
        				arr[j] = 0
        				break
      				end
    			end
  			end
		end
		return arr
	end


	
							
					
				

end

