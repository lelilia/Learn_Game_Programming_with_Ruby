class HappyFriend
	SPEED = 4
	attr_reader :x, :y, :radius

	def initialize(window, x, y)
		@radius = 32
		@x = x
		@y = y
		@image = Gosu::Image.new('images/Phantom_Open_Emoji_1f60a.png')
	end

	def move
		@y +=SPEED
	end

	def draw
		@image.draw(@x - @radius, @y - @radius, 1)
	end
end