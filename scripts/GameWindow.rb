class GameWindow < Gosu::Window

	def initialize
		super(640, 480, false)
		self.caption = "Shifter"
		@map = Map.new
		@background_image = Gosu::Image.new("graphics/space.png", :tileable => true)
	end
	
	def update
		@map.update
	end
	
	def draw
		@map.draw
		@background_image.draw(0, 0, 0)
	end

	def button_down(id)
		if id == Gosu::KB_ESCAPE
			close
		else
			super
		end
	end
end