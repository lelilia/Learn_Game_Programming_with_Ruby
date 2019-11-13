require 'gosu'
require_relative 'square'

class Test < Gosu::Window
	def initialize
		super(440, 440)
		self.caption = "2048 Test"
		@square1 = Square.new(self, 1, 3, 4)
		@square2 = Square.new(self, 1, 2, 2)
	end

	def draw
		@square1.draw
		@square2.draw
	end
end

window = Test.new
window.show