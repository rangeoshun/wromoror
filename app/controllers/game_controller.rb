require "shared/game"
require "server/player"

class GameController < WebsocketRails::BaseController
  def initialize_session
  end

  def client_connected
    player = Player.new(connection)
    Game.instance.players.push(player)

    init_message = {:message => {}}
    send_message(:game_state, init_message)
  end

  def client_input
    print message
  end
end
