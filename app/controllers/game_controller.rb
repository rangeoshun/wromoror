require 'json'
require "server/player"

class GameController < WebsocketRails::BaseController
  def initialize_session
  end

  def client_connected
    player = Player.new(connection)
    Wromoror::GAME.players.push(player)

    init_message = {:message => {}}
    WebsocketRails.users[connection.id].send_message(:game_state, init_message)
  end

  def client_updated
    WebsocketRails.logger.info
  end

  def client_input
    print message
  end
end
