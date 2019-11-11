require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'


class SectorFive < Gosu::Window
	WIDTH = 800
	HEIGHT = 600
	ENEMY_FREQUENCY = 0.05

	def initialize
		super(WIDTH, HEIGHT)
		self.caption = 'Sector Five'
		@player = Player.new(self)
		@enemies = []
		@bullets = []
		@explosions = []
	end

	def button_down(id)
		if id == Gosu::KbSpace
			@bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
		end
	end

	def update
		@player.turn_left  if button_down?(Gosu::KbLeft)
		@player.turn_right if button_down?(Gosu::KbRight)
		@player.accelerate if button_down?(Gosu::KbUp)
		@player.move
		if rand < ENEMY_FREQUENCY
			@enemies.push Enemy.new(self)
		end
		@enemies.each do |enemy|
			enemy.move
		end
		@bullets.each do |bullet|
			bullet.move
		end
		@enemies.dup.each do |enemy|
			@bullets.dup.each do |bullet|
				distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
				if distance < enemy.radius + bullet.radius
					@enemies.delete enemy
					@bullets.delete bullet
					@explosions.push Explosion.new(self, enemy.x, enemy.y)
				end
			end
		end
	end

	def draw
		@player.draw
		@enemies.each do |enemy|
			enemy.draw
		end
		@bullets.each do |bullet|
			bullet.draw
		end
		@explosions.each do |explosion|
			explosion.draw
		end
	end
end



window = SectorFive.new
window.show