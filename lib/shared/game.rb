require 'singleton'
require 'rails/all'
require 'logger'

require 'shared/tick'

class Game
  attr_accessor :players, :points, :is_server, :tick, :is_paused

  def initialize(is_server = false)
    @players = []
    @points = []
    @tick = Tick.new(self)
    @is_server = is_server
    @is_paused = false

    diff_update = lambda {
      ActionCable.server.broadcast(broadcasting_for(["game_channel"]), {:foo => "bar"})
      true
    }

    @tick.on_after_tick = diff_update

    @tick.start
    Rails.logger.debug "Game initialized"
  end
end
