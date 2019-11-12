require 'gosu'
require_relative 'square'

class SquareTest < Gosu::Window

	def initialize
		super(640, 640)
		self.caption = "Testing Squares"
		@square1 = Square.new(self, 0, 2, :blue)
		@square2 = Square.new(self, 1, 1, :red)
	end

	def draw
		@square1.draw
		@square2.draw
	end
end

window = SquareTest.new
window.show