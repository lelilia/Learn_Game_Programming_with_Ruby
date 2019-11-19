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
require_relative 'boulder'
require_relative 'platform'
require_relative 'wall'
require_relative 'chip'

class Escape < Gosu::Window
	GRAVITY = 400.0
	DAMPING = 0.90
	BOULDER_FREQUENCY = 0.01
	attr_reader :space

	def initialize
		super(800, 800)
		self.caption = 'Escape'
		@game_over = false
		@space = CP::Space.new
		@background = Gosu::Image.new('images/background.png', tileable: true)
		@space.damping = DAMPING
		@space.gravity = CP::Vec2.new(0.0, GRAVITY)
		@boulders = []
		@platforms = malke_platforms

		@floor = Wall.new(self, 400, 810, 800, 20)
		@left_wall = Wall.new(self, -10, 400, 20, 800)
		@right_wall = Wall.new(self, 810, 470, 20, 660)
		@player = Chip.new(self, 70, 700)
	end

	def malke_platforms
		platforms = []
		platforms.push Platform.new(self, 150, 700)
		platforms.push Platform.new(self, 320, 650)
		platforms.push Platform.new(self, 150, 500)
		platforms.push Platform.new(self, 470, 550)
		return platforms
	end

	def update
		unless @game_over
			10.times do  
				@space.step(1.0/600)
			end
			if rand < BOULDER_FREQUENCY
				@boulders.push Boulder.new(self, 200 + rand(400), -20)
			end
			@player.check_footing(@platforms + @boulders)
		
			if button_down?(Gosu::KbRight)
				@player.move_right
			elsif button_down?(Gosu::KbLeft)
				@player.move_left
			else
				@player.stand
			end
		end	
	end

	def button_down(id)
		if id == Gosu::KbSpace
			@player.jump
		end
		if id == Gosu::KbQ or id == Gosu::KbEscape
			close
		end
	end

	def draw
		@background.draw(0, 0, 0)
		@background.draw(0, 529, 0)
		@boulders.each do |boulder|
			boulder.draw
		end
		@platforms.each do |platform|
			platform.draw
		end
		@player.draw
	end

	
end

window = Escape.new
window.show
