class HappyFriend
	SPEED = 4
	attr_reader :x, :y, :radius, :angle, :speed

	def initialize(window, x, y)
		@radius = 32
		@x = x
		@y = y
		@angle = Gosu::angle(0,0,0,SPEED)
		@v_x = Gosu::offset_x(@angle, SPEED)
		@v_y = Gosu::offset_y(@angle,SPEED)	
		@image = Gosu::Image.new('images/Phantom_Open_Emoji_1f60a.png')
		@speed = SPEED
	end

	def move
		@x += @v_x
		@y += @v_y
		@angle = Gosu::angle(0,0,@v_x,@v_y)
	end

	def draw
		@image.draw(@x - @radius, @y - @radius, 1)
	end

	def what_is_the_angle
		Gosu::angle(0,0,@v_x, @v_y)
	end
	def set_velocity (v_x, v_y)
		@v_x = 0
		@v_y = SPEED
	end
end