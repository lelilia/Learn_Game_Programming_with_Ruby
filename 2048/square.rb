require 'gosu'

class Square
	FONT_SIZE = 45
	SQUARE_SIZE = 100
	SQUARE_BORDER = 4
	attr_reader :row, :col, :val

	def initialize(window, col, row, val)
		@@colors ||= {c2: Gosu::Color.argb(0xaac065eb),
					  c4: Gosu::Color.argb(0xaaae2deb),
					  c8: Gosu::Color.argb(0xaacb2deb),
					 c16: Gosu::Color.argb(0xaaeb2deb),
					 c32: Gosu::Color.argb(0xaac41ac4),
					 c64: Gosu::Color.argb(0xaadb35b7),
					c128: Gosu::Color.argb(0xaad10fa7),
					c256: Gosu::Color.argb(0xaad64f9e),
					c512: Gosu::Color.argb(0xaae62294),
				   c1024: Gosu::Color.argb(0xaae62263),
				   c2048: Gosu::Color.argb(0xaaeb0753)}
		@@window ||= window
		@@font ||= Gosu::Font.new(FONT_SIZE)
		@row = row
		@col = col 
		@val = val
		@highlight = false
	end

	def draw
		if @val != 0
			x1 = 22 + @col * SQUARE_SIZE
			y1 = 22 + @row * SQUARE_SIZE
			x2 = x1 + SQUARE_SIZE - SQUARE_BORDER
			y2 = y1
			x3 = x2
			y3 = y2 + SQUARE_SIZE - SQUARE_BORDER
			x4 = x1
			y4 = y3

			if @val > 2048
				@color = Gosu::Color.argb(0xaaeb07ff)
			else
				@color = ("c"+@val.to_s).to_sym
			end
			c = @@colors[@color]
			if @highlight == true
				c = Gosu::Color::WHITE
			end
			@@window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 1)
			x_center = x1 + (SQUARE_SIZE - SQUARE_BORDER) / 2
			x_text = x_center - @@font.text_width("#{@val}") / 2
			y_text = y1 + (SQUARE_SIZE - SQUARE_BORDER - FONT_SIZE)/2
			@@font.draw_text("#{@val}", x_text, y_text, 2)
		end
	end

	def clear
		@val = 0
	end

	def set (val, highlight)
		@val = val
		@highlight = highlight
	end
end