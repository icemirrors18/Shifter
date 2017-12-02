require 'gosu'
require 'rubygems'

require_relative 'scripts/GameWindow'
require_relative 'scripts/Map'
require_relative 'scripts/Player'
require_relative 'scripts/GameOver'
require_relative 'scripts/TitleScreen'

include Gosu

$window = GameWindow.new
$window.show