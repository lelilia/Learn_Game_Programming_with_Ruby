require 'gosu'

class Square
	FONT_SIZE = 45
	SQUARE_SIZE = 100
	SQUARE_BORDER = 4
	attr_reader :row, :col, :val

	def initialize(window, col, row, val)
		#@@colors ||= {c1: Gosu::Color.argb(0xaac065eb),
		#			  c2: Gosu::Color.argb(0xaaae2deb),
		#			  c3: Gosu::Color.argb(0xaacb2deb),
		#			  c5: Gosu::Color.argb(0xaaeb2deb),
		#			  c8: Gosu::Color.argb(0xaac41ac4),
		#			 c13: Gosu::Color.argb(0xaadb35b7),
		#			 c21: Gosu::Color.argb(0xaad10fa7),
		#			 c34: Gosu::Color.argb(0xaad64f9e),
		#			 c55: Gosu::Color.argb(0xaae62294),
		#		     c89: Gosu::Color.argb(0xaae62263),
		#		    c144: Gosu::Color.argb(0xaaeb0753)}
		@@window ||= window
		@@font ||= Gosu::Font.new(FONT_SIZE)
		@row = row
		@col = col 
		@val = val
		@highlight = :default
	end

	def get_color(val)
		r = (230 + 15 * val%10)%255
		g = (170 - 10*val) % 255
		b = (200 - 10 * val%10) %255
		return Gosu::Color.argb(200 , r, g, b)
	end

	def draw
		if @val != 0
			left   = 22 + @col * SQUARE_SIZE
			top    = 22 + @row * SQUARE_SIZE
			right  = left + SQUARE_SIZE - SQUARE_BORDER
			bottom = top  + SQUARE_SIZE - SQUARE_BORDER
			x_center = left + (SQUARE_SIZE - SQUARE_BORDER) / 2
			x_text = x_center - @@font.text_width("#{@val}") / 2
			y_text = top + (SQUARE_SIZE - SQUARE_BORDER - FONT_SIZE)/2

			change = 0

			#if @val > 144
			#	c = Gosu::Color.argb(0xaaeb07ff)
			#else
			#	@color = ("c"+@val.to_s).to_sym
			#	c = @@colors[@color]
			#end
			c = get_color(@val)
			
			if @highlight == :new
				@new_frame_count ||= 1
				if @new_frame_count < 16
					change = - SQUARE_SIZE * (16 - @new_frame_count) / 32
					@new_frame_count += 1
				else
					@highlight = :default
					@new_frame_count = nil 
				end
			elsif @highlight == :merge
				@merge_frame_count ||= 1
				if @merge_frame_count < 16
					change = 4.0 / 16 * @merge_frame_count
					@merge_frame_count += 1
				else
					@highlight = :default
					@merge_frame_count = nil
				end
			end



			

			left -= change
			right += change
			top -= change
			bottom += change

			@@window.draw_quad(left, top, c, right, top, c, right, bottom, c, left, bottom, c, 1)
			
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