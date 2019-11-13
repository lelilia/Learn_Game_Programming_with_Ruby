require 'gosu'
require_relative 'game'

class Game2048 < Gosu::Window

	def initialize
		super(440, 440)
		self.caption = '2048'
		@game = Game.new(self)
	end

	def draw
		@game.draw
	end
end

window = Game2048.new
window.show