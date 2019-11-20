class Friend
	SPEED = 4
	attr_reader :x, :y, :radius

	def initialize(window)
		@radius = 32
		@x = rand(window.width - 2 * @radius) + @radius
		@y = 0
		@image = Gosu::Image.new('images/Phantom_Open_Emoji_1f614.png')
	end

	def move
		@y +=SPEED
	end

	def draw
		@image.draw(@x - @radius, @y - @radius, 1)
	end
end