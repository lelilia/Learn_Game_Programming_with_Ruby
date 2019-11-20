class Player
	ROTATION_SPEED = 3
	ACCELARATION = 2
	FRICTION = 0.9
	attr_reader :x, :y, :angle, :radius

	def initialize(window)
		@x = 200
		@y = 200
		@angle = 0
		@image = Gosu::Image.new('images/Phantom_Open_Emoji_1f60d.png')
		@velocity_x = 0
		@velocity_y = 0
		@radius = 64
		@window = window
	end

	def turn_right
		@angle += ROTATION_SPEED
	end

	def turn_left
		@angle += ROTATION_SPEED
	end

	def accelerate
		@velocity_x += Gosu::offset_x(@angle, ACCELARATION)
		@velocity_y += Gosu::offset_y(@angle, ACCELARATION)
	end

	def move
		@x += @velocity_x
		@y += @velocity_y
		@velocity_x *= FRICTION
		@velocity_y *= FRICTION
		if @x < @radius
			@velocity_x = 0
			@x = @radius
		end
		if @y > @window.height - @radius
			@velocity_y = 0
			@y = @window.height - @radius
		end
	end

	def draw 
		@image.draw_rot(@x, @y, 1, @angle)
	end
end