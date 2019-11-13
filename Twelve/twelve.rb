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

	def button_down(id)
		if id == Gosu::MsLeft
			@game.handle_mouse_down(mouse_x, mouse_y)
		end
		if id == Gosu::KbR
			@game = Game.new(self)
		end
	end

	def button_up(id)
		if id == Gosu::MsLeft
			@game.handle_mouse_up(mouse_x, mouse_y)
		end
	end

	def update
		@game.handle_mouse_move(mouse_x, mouse_y)
	end

end

window = Twelve.new
window.show