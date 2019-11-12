require 'gosu'
require_relative 'game'

class Twelve < Gosu::Window

	def initialize
		super(640, 640)
		self.caption = 'Twelve'
		@game = Game.new(self)
	end

	def draw
		@game.draw
	end

	def needs_cursor?
		true
	end

end

window = Twelve.new
window.show