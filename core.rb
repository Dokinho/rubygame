# To make bundler work
require "rubygems"
require "bundler/Setup"

# Requires all files from "lib" folder
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

class Game

end

def game_loop
  loop do
    State.menu
  end
end

game_loop