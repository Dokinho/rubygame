# To make bundler work
require "rubygems"
require "bundler/Setup"

require "tty-prompt"
require "tty-reader"

# Requires all files from "lib" folder
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

# -----TEST-----
@igrac = Player.new
@zloco = Enemy.new(10, 1, 100)
@mapa = Map.new("Mapa", 20, 20)

@mapa.add_object(@igrac, 0, 1)
@mapa.add_object(@zloco, 5, 5)

@prompt = TTY::Prompt.new
@reader = TTY::Reader.new

class Game

end

def game_loop
  State.init(@prompt, @reader, @igrac, @mapa)
  choice = "Menu"
  loop do
    choice = eval("State.#{choice.downcase}")
  end
end

game_loop