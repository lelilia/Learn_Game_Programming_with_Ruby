class Friend
	SPEED = 4
	attr_reader :x, :y, :radius, :angle

	def initialize(window)
		@radius = 32
		@x = rand(window.width - 2 * @radius) + @radius
		@y = 0
		@angle = rand(140) + 110
		@v_x = Gosu::offset_x(@angle, SPEED)
		@v_y = Gosu::offset_y(@angle,SPEED)
		@image = Gosu::Image.new('images/Phantom_Open_Emoji_1f614.png')
		@window = window
	end

	def move
		@x += @v_x
		@y += @v_y
		if @x > @window.width - @radius or @x < @radius
			@v_x = - @v_x
		end
		if @y > @window.height - @radius
			@v_y = -@v_y
		end

	end

	def draw
		@image.draw(@x - @radius, @y - @radius, 1)
	end
end