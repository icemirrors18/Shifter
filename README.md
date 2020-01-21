Main.exe can be used to play the game on windows machines with no setup.
To run from source, you must have Ruby 2.4.2 (https://www.ruby-lang.org/en/documentation/installation/) and the gosu gem (gem install gosu)

Once requirements are installed, simply open the console and type "ruby main.rb" in the base folder of Shifter

The goal of the game is to pass through lines that are the same color as your ship, which increases
your score and multiplier.  If you hit a line of a different color than your ship, the game is over.
The controls are as follows:

left arrow - switch one lane to the left
right arrow - switch one lane to the right
up arrow - increase speed by 5 and increase score multiplier by 3
down arrow - decrease speed to (2/3)speed and decrease score multiplier by 5 (require a multiplier >= 5.5)
spacebar - switch between red and blue colored ship
