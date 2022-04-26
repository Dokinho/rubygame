require_relative '../core.rb'

RSpec.describe "core.rb" do

  it 'has a class named Game' do
    expect(Game).to be_a Class
  end

  it 'has a loop method which runs the game logic' do
    expect(self).to receive(:game_loop)
    game_loop
  end

end