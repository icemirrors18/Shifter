class Player

	def initialize()
		@x = 290
		@lane = 2
		@color = 1
		@redShip = Gosu::Image.new("graphics/starfighter_red.bmp", false)
		@blueShip = Gosu::Image.new("graphics/starfighter_blue.bmp", false)
		@sprite = @redShip

	end
	
	def draw(z=5)
		@sprite.draw(@x, 400, z)
	end
	
	def update
		
	end

	def warp_left()
		if @lane > 1
			@lane = @lane - 1
			@x = @x - 200
		end
	end

	def warp_right()
		if @lane < 3
			@lane = @lane + 1
			@x = @x + 200
		end
	end
	
	def getcolor()
		return @color
	end
	
	def getx()
		return @x
	end
	
	def swap()
		if @color == 1 then
			@color = 2
			@sprite = @blueShip
		else
			@color = 1
			@sprite = @redShip
		end
	end
	
end