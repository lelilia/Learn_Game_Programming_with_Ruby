class Heart
	SPEED = 5
	attr_reader :x, :y, :radius

	def initialize(window, x, y, angle)
		@x = x
		@y = y
		@direction = angle
		@image1 = Gosu::Image.new('images/Emoji_u1f497.png')
		@image2 = Gosu::Image.new('images/Emoji_u1f496.png')
		@radius = 16
		@window = window
		@image_index = 0
	end

	def onscreen?
		right  = @window.width + @radius
		left   = - @radius
		top    = - @radius
		bottom = @window.height + @radius
		@x > left and @x < right and @y > top and @y < bottom
	end

	def move
		@x += Gosu.offset_x(@direction, SPEED)
		@y += Gosu.offset_y(@direction, SPEED)
	end

	def draw
		if @image_index < 10
			@image1.draw(@x - @radius, @y - @radius, 1)
			@image_index += 1
		else
			@image2.draw(@x - @radius, @y - @radius, 1)
			@image_index = (@image_index + 1) % 20
		end
	end
end
