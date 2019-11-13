require 'gosu'
require_relative 'square'

class Test < Gosu::Window
	def initialize
		super(440, 440)
		self.caption = "2048 Test"
		@square1 = Square.new(self, 0, 0, 2)
		@square2 = Square.new(self, 0, 1, 4)
		@s3 = Square.new(self, 0,2,8)

	end

	def draw
		@square1.draw
		@square2.draw
		@s3.draw
	end
end

window = Test.new
window.show