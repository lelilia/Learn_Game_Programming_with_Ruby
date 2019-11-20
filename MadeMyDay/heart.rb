class Heart
	SPEED = 5
	attr_reader :x, :y, :radius

	def initialize(window, x, y, angle)
		@x = x
		@y = y
		@directon = angle
		@image = Gosu::Image.new('images/Emoji_u1f497.png')
		@radius = 16
		@window = window
	end

	def onscreen?
		right = @window.width + @radius
		left = -@radius
		top = -@radius
		bottom = @window.height + @radius
		@x > left and @x < right and @y > top and @y < bottom
	end

	def move 
		@x += Gosu.offset_x(@directon, SPEED)
		@y += Gosu.offset_y(@directon, SPEED)
	end

	def draw
		@image.draw(@x - @radius, @y - @radius, 1)
	end
end