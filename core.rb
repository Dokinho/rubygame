# To make bundler work
require "rubygems"
require "bundler/Setup"

Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

class Game

end

def game_loop
    State.menu
end

game_loop