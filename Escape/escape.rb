#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---

require 'gosu'
require 'chipmunk'

class Escape < Gosu::Window
	GRAVITY = 400.0
	DAMPING = 0.90
	attr_reader :space

	def initialize
		super(800, 800)
		self.caption = 'Escape'
		@game_over = false
		@space = CP::Space.new
		@background = Gosu::Image.new('images/background.png', tileable: true)
		@space.damping = DAMPING
		@space.gravity = CP::Vec2.new(0.0, GRAVITY)
	end

	def update
		unless @game_over
			10.times do  
				@space.step(1.0/600)
			end
		end
	end
end

window = Escape.new
window.show
