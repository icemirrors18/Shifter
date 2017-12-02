class GameOver

	def initialize
		@over = Gosu::Image.from_text("Game Over", 50)
		@message = Gosu::Image.from_text("Press Space to Play Again!", 50)
		File.open('scripts/highscore.txt', 'r') do |f1|
			while line = f1.gets
				@hs = Gosu::Image.from_text("Highscore: " + line, 50)
			end
		end
		@newhs = Gosu::Image.from_text("Congratulations! New Highscore!", 50)
		@z = 0
		@z2 = 0
		@z3 = 0
		@z4 = 0
	end
	
	def draw
		@over.draw(200, 200, @z)
		@message.draw(75, 250, @z2)
		@hs.draw(190, 150, @z3)
		@newhs.draw(5, 100, @z4)
		
	end
	
	def update
	
	end

	def show
		@z = 5
		@z2 = 5
		@z3 = 5
	end
	
	def hide
		@z = 0
		@z2 = 0
		@z3 = 0
		@z4 = 0
	end
	
	def showHS
		File.open('scripts/highscore.txt', 'r') do |f1|
			while line = f1.gets
				@hs = Gosu::Image.from_text("Highscore: " + line, 50)
			end
		end
		@z4 = 5
	end
	
end