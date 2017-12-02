class TitleScreen

	def initialize()
		@title = Gosu::Image.from_text("SHIFTER", 100)
		@controls = Gosu::Image.from_text("Controls:\nLeft Arrow: Move left 1 lane\nRight Arrow: Move right 1 lane\nDown Arrow: Decrease speed and multiplier\nUp Arrow: Increase Speed and multiplier\nSpace Bar: Change Color\n\nPress Space to Start!", 20)
		@z = 5
	end
	
	def draw
		@title.draw(125, 100, @z)
		@controls.draw(240, 200, @z)
	end
	
	def update
	
	end
	
	def hide
		@z = 0
	end
	
end