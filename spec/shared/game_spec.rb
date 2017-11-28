require 'shared/game'

RSpec.describe Updatable do
  context "is instantiable" do
    it "without crashing" do
      expect(Game.new).to be_truthy
    end

    it "with empty players list" do
      game = Game.new
      players = game.players
      expect(players).to be_instance_of Array
      expect(players.length).to eq 0
    end

    it "with points list" do
      game = Game.new
      points = game.points
      expect(points).to be_instance_of Array
    end
  end
end
