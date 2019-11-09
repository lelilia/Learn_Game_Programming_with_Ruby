require 'gosu'

class WhackARuby < Gosu::Window
	def initialize
		super(800,600)
		self.caption = 'Whack the Ruby!'
		@image = Gosu::Image.new('ruby.png')
		@x = 200
		@y = 200
		@width = 50
		@height = 43
		@velocity_x = 1
		@velocity_y = 1
		@visible = 0
		@hammer_image = Gosu::Image.new('hammer.png')
		@hit = 0
		@font = Gosu::Font.new(30)
		@score = 0

	end

	def update
		@x += @velocity_x
		@y += @velocity_y
		@velocity_x *= -1 if @x + @width  / 2 > 800 || @x - @width  / 2 < 0
		@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0
		@visible -= 1
		@visible = 300 if @visible < -10 && rand < 0.01
	end

	def button_down(id)
		if (id == Gosu::MsLeft)
			if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
        		@hit = 1
        		@score += 5
			else
				@hit = -1
				@score -= 1
			end
		end
	end

	def draw
		if @visible > 0
			@image.draw(@x - @width / 2, @y - @height/2, 1)
		end
		@hammer_image.draw(mouse_x - 40, mouse_y - 10, 1)
		if @hit == 0
      		c = Gosu::Color::NONE
    	elsif @hit == 1
      		c = Gosu::Color::GREEN
    	elsif @hit == -1
      		c = Gosu::Color::RED
    	end
    	draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    	@hit = 0
    	@font.draw(@score.to_s, 700, 20, 2)
	end

end

window = WhackARuby.new
window.show