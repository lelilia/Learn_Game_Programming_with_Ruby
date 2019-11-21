class HappyFriend
	SPEED = 4
	attr_reader :x, :y, :radius, :angle

	def initialize(window, x, y)
		@radius = 32
		@x = x
		@y = y
		@image = Gosu::Image.new('images/Phantom_Open_Emoji_1f60a.png')
		@angle = Gosu::angle(0,0,0,SPEED)
	end

	def move
		@y +=SPEED
	end

	def draw
		@image.draw(@x - @radius, @y - @radius, 1)
	end

	def what_is_the_angle
		Gosu::angle(0,0,0,SPEED)
	end
	def set_velocity (x, y)
		
	end
end