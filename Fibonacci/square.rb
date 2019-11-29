require 'gosu'

class Square
	FONT_SIZE = 45
	SQUARE_SIZE = 100
	SQUARE_BORDER = 4
	attr_reader :row, :col, :val

	def initialize(window, col, row, val)
		@@color_array_original = [0xffc065eb, 0xffae2deb, 0xffcb2deb, 0xffc41ac4, 0xffdb35b7, 0xffd10fa7, 0xffd64f9e, 0xffe62263, 0xffe62294, 0xffeb0753,
								  0xffeb2d9b, 0xffeb2daf, 0xffeb2dc3, 0xffeb2dd7, 0xffeb2deb, 0xffd72deb, 0xffc32deb, 0xffaf2deb, 0xff9b2deb, 0xffc165eb,
								  0xffae2deb, 0xffcb2deb, 0xffc41ac4, 0xffdb35b7, 0xffd10fa7, 0xffd64f9e, 0xffe62294, 0xffe62263, 0xffeb0753, 0xff4b0082, 
								  0xff800080, 0xffff00ff, 0xffda70d6, 0xffff1493, 0xffff69b4]
		@@color_array = @@color_array_original.shuffle
		@@color_value = {}
		@@window ||= window
		@@font ||= Gosu::Font.new(FONT_SIZE)
		@row = row
		@col = col 
		@val = val
		@highlight = :default
	end

	def get_color(val)
		if @@color_array == []
			@@color_array = @@color_array_original.shuffle
		end
		if not @@color_value.keys.include? val
			@@color_value[val] = Gosu::Color.argb(@@color_array.pop)
		end
		return @@color_value[val]
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