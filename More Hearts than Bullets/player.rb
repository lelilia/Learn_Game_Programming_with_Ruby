class Player
	ROTATION_SPEED = 3
	ACCELARATION = 1.5
	FRICTION = 0.9
	attr_reader :x, :y, :angle, :radius

	def initialize(window)
		@x = 400
		@y = 500
		@angle = 0
		@image = Gosu::Image.new('images/Phantom_Open_Emoji_1f60d.png')
		@velocity_x = 0
		@velocity_y = 0
		@radius = 32
		@window = window
	end

	def turn_right
		@angle += ROTATION_SPEED
	end

	def turn_left
		@angle -= ROTATION_SPEED
	end

	def accelerate
		@velocity_x += Gosu::offset_x(@angle, ACCELARATION)
		@velocity_y += Gosu::offset_y(@angle, ACCELARATION)
	end

	def backwards
		@velocity_x -= Gosu::offset_x(@angle, ACCELARATION)
		@velocity_y -= Gosu::offset_y(@angle, ACCELARATION)
	end

	def move
		@x += @velocity_x
		@y += @velocity_y
		@velocity_x *= FRICTION
		@velocity_y *= FRICTION
		if @x > @window.width - @radius
			@velocity_x = 0
			@x = @window.width - @radius
		elsif @x < @radius
			@velocity_x = 0
			@x = @radius
		end
		if @y > @window.height - @radius
			@velocity_y = 0
			@y = @window.height - @radius
		elsif @y < @radius
			@velocity_y = 0
			@y = @radius
		end
	end

	def draw
		@image.draw_rot(@x, @y, 2, @angle)
	end
end
			
			