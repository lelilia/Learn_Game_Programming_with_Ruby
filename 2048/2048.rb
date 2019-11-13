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

	def button_down(id)
		if id == Gosu::KbR
			@game = Game.new(self)
		elsif id == Gosu::KbUp
			#move up
			@game.move(:up)
		elsif id == Gosu::KbDown
			#move down
			@game.move(:down)
		elsif id == Gosu::KbLeft
			#move left
			@game.move(:left)
		elsif id == Gosu::KbRight
			#move right
			@game.move(:right)
		elsif id == Gosu::KbEscape
			close
			
		end
				
				
			
	end
end

window = Game2048.new
window.show