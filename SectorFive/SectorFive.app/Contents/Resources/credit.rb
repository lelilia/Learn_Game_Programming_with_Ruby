class Credit
	SPEED = 1
	attr_reader :y

	def initialize(window, text, x, y)
		@x = x
		@y = @initial_y = y
		@text = text
		@font = Gosu::Font.new(24)
	end

	def move
		@y -= SPEED
	end

	def draw
		@font.draw_text(@text, @x, @y, 1, 1, 1, Gosu::Color::WHITE)
		#@font.draw(@text, @x, @y, 1)
	end

	def reset
		@y = @initial_y
	end

end