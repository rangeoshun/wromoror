require 'singleton'
require 'rails/all'

require 'shared/tick'

class Game
  attr_accessor :players, :points, :is_server, :tick

  def initialize(is_server = false)
    @players = []
    @points = []
    @tick = Tick.new(self)
    @is_server = is_server
    @is_paused = false

    Rails.logger.info "Game initialized"

    @tick.on_before_tick = lambda { |players, points|
      print players
      print points
    }

    @tick.start
  end
end
