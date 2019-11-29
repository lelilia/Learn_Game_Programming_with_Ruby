require 'gosu'
require_relative 'player'
#require_relative 'friend'
require_relative 'credit'
require_relative 'heart'

class MoreHearts < Gosu::Window
	WIDTH = 800
	HEIGHT = 600
	FRIEND_FREQUENCY = 0.01
	MAX_FRIENDS = 10
	
	def initialize
		super(WIDTH, HEIGHT)
		self.caption = "More Hearts than Bullets"
		@background_image = Gosu::Image.new('images/start_screen.png')
		@scene = :start
	end

	def initialize_game
		@scene = :game 
		@level = 1
		@font = Gosu::Font.new(24)
		@player = Player.new(self)
		@hearts = []
		@friends = []
		@friends_have_left = {sad: 0, happy: 0}
	end

	def initialize_end
		@scene = :end
		@message = "Oh no! #{@friends_have_left[sad]} friends of you left while still being sad."
		@message2 = "But you cheered #{@friends_have_left[happy]} friends up! So great!"
		@bottom_message = "Press P to play again, or Q to quit."
		@message_font = Gosu::Font.new(28)
		@credits = []
		y = 500
		File.open('credit.txt').each do |line|
			@credits.push(Credit.new(self, line.chomp, 100, y))
			y += 30
		end
	end

	def update
		case @scene
		when :game
			update_game
		when :end
			update_end
		end
	end

	def update_game
		@player.turn_left if button_down?(Gosu::KbLeft)
		@player.turn_right if button_down?(Gosu::KbRight)
		@player.accelerate if button_down?(Gosu::KbUp)
		@player.backwards if button_down?(Gosu::KbDown)
		@player.move

		@hearts.each do |heart|
			heart.move
		end
	end

	def update_end
		@credits.each do |credit|
			credit.move
		end
		if @credits.last.y < 100
			@credits.each do |credit|
				credit.reset
			end
		end
	end

	def draw
		case @scene
		when :start
			draw_start
		when :game
			draw_game
		when :end
			draw_end
		end
	end

	def draw_start
		@background_image.draw(0,0,0)
	end

	def draw_game
		@player.draw
		@hearts.each do |heart|
			heart.draw
		end
	end

	def draw_end
		clip_to(50, 140, 700, 360) do
			@credits.each do |credit|
				credit.draw
			end
		end
		draw_line(0,140,Gosu::Color.argb(0xffff69b4), WIDTH, 140, Gosu::Color.argb(0xffff69b4))
		@message_font.draw_text(@message, 40, 40, 1, 1, 1, Gosu::Color.argb(0xffeb2daf))
		@message_font.draw_text(@message2, 40, 75, 1, 1, 1, Gosu::Color.argb(0xffeb2daf))
		draw_line(0,500, Gosu::Color.argb(0xffff69b4), WIDTH, 500, Gosu::Color.argb(0xffff69b4))
		@message_font.draw_text(@bottom_message, 180, 540, 1, 1, 1, Gosu::Color.argb(0xffae2deb))
	end

	def button_down(id)
		case @scene
		when :start
			button_down_start(id)
		when :game
			button_down_game(id)
		when :end
			button_down_end(id)
		end
	end

	def button_down_start(id)
		if id == Gosu::KbEscape
			close
		end
		initialize_game
	end

	def button_down_game(id)
		if id == Gosu::KbEscape
			close
		end
		if id == Gosu::KbSpace
			@hearts.push Heart.new(self, @player.x, @player.y, @player.angle)
		end
	end

	def button_down_end(id)
		if id == Gosu::KbUp
			initialize_game
		elsif id == Gosu::KbQ or id == Gosu::KbEscape
			close
		end
	end
end

window = MoreHearts.new
window.show
