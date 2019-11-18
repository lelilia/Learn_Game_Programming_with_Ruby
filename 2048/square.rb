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
		@highlight = :default
	end

	def draw
		if @val != 0
			left   = 22 + @col * SQUARE_SIZE
			top    = 22 + @row * SQUARE_SIZE
			right  = left + SQUARE_SIZE - SQUARE_BORDER
			bottom = top  + SQUARE_SIZE - SQUARE_BORDER

			change = 0
			if @highlight == :new
				change = SQUARE_SIZE / 5
				@highlight = :new2
			elsif @highlight == :new2
				change = SQUARE_SIZE / 4
				@highlight = :new3
			elsif @highlight == :new3
				change = SQUARE_SIZE / 3
				@highlight = :new4
			elsif @highlight == :new4
				change = SQUARE_SIZE / 2
				@highlight = :new4
			end

				

			if @highlight == :merge
				left   -= SQUARE_BORDER / 2
				top    -= SQUARE_BORDER / 2
				right  += SQUARE_BORDER / 2
				bottom += SQUARE_BORDER / 2
			end

			left -= change
			right += change
			top += change
			bottom -= change

			

			if @val > 2048
				@color = Gosu::Color.argb(0xaaeb07ff)
			else
				@color = ("c"+@val.to_s).to_sym
			end
			c = @@colors[@color]
			if @highlight == :merge or @highlight == :new
				c = Gosu::Color::WHITE
			end
			@highlight = :default
			@@window.draw_quad(left, top, c, right, top, c, right, bottom, c, left, bottom, c, 1)
			x_center = left + (SQUARE_SIZE - SQUARE_BORDER) / 2
			x_text = x_center - @@font.text_width("#{@val}") / 2
			y_text = top + (SQUARE_SIZE - SQUARE_BORDER - FONT_SIZE)/2
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