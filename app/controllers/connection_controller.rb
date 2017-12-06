class ConnectionController < WebsocketRails::BaseController
  List = []

  def initialize_session
  end

  def client_connected
    print message
    print WebsocketRails.users
  end
end
