class Map

	def initialize
		#Sets up basic pieces of the game and variable values
		@player = Player.new()
		@gameover = GameOver.new()
		@title = TitleScreen.new()
		@song = Gosu::Song.new('music/Mega_Hyper_Ultrastorm.mp3')
		@song.play
		@score = 0
		@scoremult = 1
		@slowavailable = false
		@dead = false
		@started = false
		
		#Sets up arrays holding information about line positions and colors
		@linecolors = Array.new(3)
		@linecolorsints = Array.new(3)
		@lineys = Array.new(3)
		for x in 0..2 do
			@linecolors[x] = Gosu::Color.argb(0xff_ff0000)
			@linecolorsints[x] = 1
			@lineys[x] = 0
		end
		
		#Sets up X start and end locations for each lane
		@line1start = 0
		@line1end = 213
		@line2start = 213.001
		@line2end = 417
		@line3start = 417.001
		@line3end = 640
		
		#Sets up delays to avoid rapid execution of methods
		@ycheck = 0
		@speed = 1
		@scored = false
		@swapdelay = 0
		@movedelay = 0
		@scoredelay = 0
		@overdelay = 0
		
		File.open('scripts/highscore.txt', 'r') do |f1|
			while line = f1.gets
				@highscore = line.to_i
			end
		end
	end
	
	def update
		#If the player has not died, check for input, act accordingly,
		#then advance all the lines on the screen and check for collision
		if !@started then
			if $window.button_down?(KB_SPACE) then
				@title.hide
				@started = true
				@swapdelay = 10
			end
		elsif !@dead then
			@player.update
			if $window.button_down?(KB_SPACE) and @swapdelay == 0 then
				@player.swap
				@swapdelay = 10
			elsif $window.button_down?(KB_LEFT) and @movedelay == 0 then
				@player.warp_left
				@movedelay = 10
			elsif $window.button_down?(KB_RIGHT) and @movedelay == 0 then
				@player.warp_right
				@movedelay = 10
			elsif $window.button_down?(KB_DOWN) and @movedelay == 0 then
				slow_down
				@movedelay = 10
			elsif $window.button_down?(KB_UP) and @movedelay == 0 then
				speed_up
				@movedelay = 10
			end
			if @swapdelay > 0 then
				@swapdelay -= 1
			end
			if @movedelay > 0 then
				@movedelay -= 1
			end
			#If the lines have reached the bottom of the screen, randomly choose
			#if a line appears in a lane for this cycle and assigns it 
			#a random color to the line
			if @ycheck > 480 then
				for x in 0..2
					@temp = rand(100)
					if @temp < 70 then
						@lineys[x] = 0
						@temp = rand(100)
						if @temp < 50 then
							@linecolors[x] = Gosu::Color.argb(0xff_ff0000)
							@linecolorsints[x] = 1
						else
							@linecolors[x] = Gosu::Color.argb(0xff_0000ff)
							@linecolorsints[x] = 2
						end
					end
				end
				#Increase speed if not already at the max
				if @speed < 15 then
					@speed += 0.33
				end
				@ycheck = 0
				@scored = false
			else
			#advance all lines in the wave
				for x in 0..2
					@lineys[x] += 1 * @speed
				end
				@ycheck += 1 * @speed
			end
			check_collision
		else
			#Player has died, display game over message and wait for
			#player to give the signal to start a new game
			@gameover.show
			if @score > @highscore then
				File.open('scripts/highscore.txt', 'w') do |f1|
					f1.puts @score.to_s
				end
				@gameover.showHS
			end
			if @overdelay > 0 then
				@overdelay -= 1
			end
			if $window.button_down?(KB_SPACE) and @overdelay == 0 then
				initialize
			end
		end
	end
	
	def draw
		#Setup the player sprite and the lines to be used aswell as the 
		#HUD information
		@player.draw
		@gameover.draw
		@title.draw
		@gameover.hide
		Gosu::draw_line(@line1start, @lineys[0], @linecolors[0], @line1end, @lineys[0], @linecolors[0], z=5, mode = :default)
		Gosu::draw_line(@line2start, @lineys[1], @linecolors[1], @line2end, @lineys[1], @linecolors[1], z=5, mode = :default)
		Gosu::draw_line(@line3start, @lineys[2], @linecolors[2], @line3end, @lineys[2], @linecolors[2], z=5, mode = :default)
		Gosu::Image.from_text("Score :" + @score.to_s, 20).draw(480,0,1)
		Gosu::Image.from_text("Score Multiplier : " + @scoremult.to_s, 20).draw(480, 30, 1)
		Gosu::Image.from_text("Slow Avaialable : " + @slowavailable.to_s, 20).draw(480, 60, 1)
	end
	
	def check_collision
		if @ycheck >= 400 and @ycheck <= 440 then
		#Lines may be at the same location as the player
			if @player.getx <= 213 then
			#Player is in lane 0
				@check = 0
			elsif @player.getx <= 417 then
			#Player is in lane 1
				@check = 1
			else
			#Player is in lane 2
				@check = 2
			end
			if @player.getcolor == @linecolorsints[@check] and @lineys[@check] >= 400 and @lineys[@check] <= 440 then
				if @scored then
					#Player matches the color of the line they are contacting
					#but has already score this wave; do nothing
				else
					#Increment player score and increase the multiplier
					@score += (10 * @scoremult).to_i
					@scoremult += 0.5
					if @scoremult > 5 then
						@slowavailable = true
					end
					@scored = true
				end
			else
				#Player is either in an empty lane of has hit an inverse line
				if @lineys[@check] >= 400 and @lineys[@check] <= 440 then
				#Player has died, display game over text
					@dead = true
					@overdelay = 30
				end
			end
		end
	end
	
	def slow_down
		if @scoremult > 5 then
		#Slow down is available and has been triggered, remove multiplier
		#and reduce speed
			@scoremult -= 5
			@speed /= 1.5
			if @scoremult <= 5 then
				@slowavailable = false
			end
		end
	end
	
	def speed_up
		if (@speed + 5) <= 15 then
		#Speed up is available and has been triggered, increase multiplier
		#and increase speed
			@scoremult += 3
			@speed += 5
		end
	end
end