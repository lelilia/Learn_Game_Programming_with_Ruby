class Friend
	SPEED = 4
	SPEED_MIN = 2
	SPEED_MAX = 8
	attr_reader :x, :y, :radius, :angle, :speed, :mood

	def initialize(window)
		@radius = 32
		@x = rand(window.width - 2 * @radius) + @radius
		@y = 0
		@angle = rand(140) + 110
		@v_x = Gosu::offset_x(@angle, SPEED)
		@v_y = Gosu::offset_y(@angle,SPEED)
		@image = Gosu::Image.new('images/Phantom_Open_Emoji_1f614.png')
		@window = window
		@speed =SPEED
	end

	def move
		@x += @v_x
		@y += @v_y
		if @x > @window.width - @radius or @x < @radius
			@v_x = - @v_x
			@angle = Gosu::angle(0,0,@v_x,@v_y)
		end
		if @y > @window.height - @radius
			@v_y = -@v_y
			@angle = Gosu::angle(0,0,@v_x,@v_y)
		end

	end

	def what_is_the_angle
		Gosu::angle(0,0,@v_x,@v_y)
	end

	def draw
		@image.draw(@x - @radius, @y - @radius, 1)
	end

	def set_velocity (v_x, v_y)
		@v_x = v_x
		@v_y = v_y
		@speed = (@v_x**2 + @v_y**2)**0.5
		if @speed > SPEED_MAX
			@v_x = Gosu::offset_x(@angle, SPEED_MAX)
			@v_y = Gosu::offset_y(@angle, SPEED_MAX)
		elsif @speed < SPEED_MIN
			@v_x = Gosu::offset_x(@angle, SPEED_MIN)
			@v_y = Gosu::offset_y(@angle, SPEED_MIN)
		end
			
	end
end