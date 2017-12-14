require 'singleton'
require 'rails/all'

require 'shared/tick'

class Game
  attr_accessor :players, :points, :is_server, :tick, :is_paused

  def initialize(is_server = false)
    @players = []
    @points = []
    @tick = Tick.new(self)
    @is_server = is_server
    @is_paused = false

    test_callback = lambda {
      WebsocketRails[:game_state].trigger(:full_state, {:message => {}})
      true
    }

    @tick.on_before_tick = test_callback

    @tick.start
    WebsocketRails.logger.info "Game initialized"
  end
end
