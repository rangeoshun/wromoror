require 'singleton'

require 'shared/tick'

class Game
  include Singleton
  attr_accessor :players, :points, :is_server, :tick

  def initialize(is_server = false)
    @players = []
    @points = []
    @tick = Tick.new(self)
    @is_server = is_server
    @is_paused = false

    @tick.on_before_tick = lambda { |players, points|
      print players
      print points
    }

    @tick.start
  end
end

Game.instance
