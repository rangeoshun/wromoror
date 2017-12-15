require 'uuidtools'

require 'server/player'

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      player = Player.new()
      Wromoror::GAME.players.push(player)
      self.current_user = player
    end
  end
end
