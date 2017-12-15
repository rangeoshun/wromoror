require "uuidtools"

class GameChannel < ActionCable::Channel::Base
  def subscribe
    @connection_token = UUIDTools::UUID.random_create.to_s
  end
end
