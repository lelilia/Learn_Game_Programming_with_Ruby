class Friend
	SPEED = 4
	attr_reader :x, :y, :radius, :angle, :speed, :mood, :hug_timer

	def initialize(window, x, y, angle, speed, mood)
		@radius = 32
		@x = x
		@y = y
		@angle = angle
		@speed = speed
		@mood = mood
		@image_sad   = Gosu::Image.new('images/Phantom_Open_Emoji_1f614.png')
		@image_happy = Gosu::Image.new('images/Phantom_Open_Emoji_1f60a.png')
		@image_hug   = Gosu::Image.new('images/Phantom_open_Emoji_1f604.png')
		@window = window
		@velocity_x = Gosu::offset_x(@angle, @speed)
		@velocity_y = Gosu::offset_y(@angle, @speed)
		@hug_timer = 0
	end

	def move
		case @mood
		when :sad 
			move_sad
		when :happy 
			move_happy
		when :hug 
			@hug_timer -= 1
		end

	end

	def move_sad
		@x += @velocity_x
		@y += @velocity_y
		if @x > @window.width - @radius 
			@x = @window.width - @radius
			@velocity_x = - @velocity_x
		elsif @x < @radius
			@x = @radius
			@velocity_x = - @velocity_x
		elsif @y > @window.height - @radius
			@y = @window.height - @radius
			@velocity_y = - @velocity_y
		end
		@angle = Gosu::angle(0,0,@velocity_x, @velocity_y)
	end

	def move_happy
		@x += @velocity_x
		@y += @velocity_y
		@angle = Gosu::angle(0,0, @velocity_x, @velocity_y)
	end

	def set_velocity(x, y, v_x, v_y)
		@x = x
		@y = y
		@velocity_x = v_x
		@velocity_y = v_y
		@angle = Gosu::angle(0,0,@velocity_x, @velocity_y)
	end

	def set_mood(mood)
		@mood = mood
	end

	def set_hug_timer
		@hug_timer = 60 unless @hug_timer != 0
	end

	def draw
		case @mood
		when :sad
			@image_sad.draw(@x - @radius, @y - @radius, 1)
		when :happy
			@image_happy.draw(@x - @radius, @y - @radius, 1)
		when :hug
			@image_hug.draw(@x - @radius, @y - @radius, 1)
		end
	end

	def onscreen?
		right  = @window.width + @radius
		left   = - @radius
		top    = - @radius
		bottom = @window.height + @radius
		@x > left and @x < right and @y > top and @y < bottom
	end

	def vx
		@velocity_x
	end

	def vy
		@velocity_y
	end

end
