require 'gosu'

class Square

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
		@@font ||= Gosu::Font.new(72)
		@row = row
		@col = col 
		@val = val
	end

	def draw
		if @val != 0
			x1 = 22 + @col * 100
			y1 = 22 + @row * 100
			x2 = x1 + 96
			y2 = y1
			x3 = x2
			y3 = y2 + 96
			x4 = x1
			y4 = y3
			@color = ("c"+@val.to_s).to_sym
			c = @@colors[@color]
			@@window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 1)
			x_center = x1 + 48
			x_text = x_center - @@font.text_width("#{@val}") / 2
			y_text = y1 + 12
			@@font.draw("#{@val}", x_text, y_text, 2)
		end
	end
end