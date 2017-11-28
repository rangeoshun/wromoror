class Game
  attr_reader :players, :points

  def initialize
    @players = []
    @points = []
    @paused = false
    @tick = nil
  end
end
