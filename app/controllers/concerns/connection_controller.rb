class ConnectionController < WebsocketRails::BaseController
  def initialize_session
  end

  def client_connected
    init_message = {:message => '{}'}
    send_message :game_state, init_message
  end

  def client_input
    print message
  end
end
