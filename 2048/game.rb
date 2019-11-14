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
        				arr[j] = 0
        				break
      				end
    			end
  			end
		end
		return arr
	end


	
							
					
				

end

