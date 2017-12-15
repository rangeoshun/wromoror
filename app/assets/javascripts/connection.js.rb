require "websocket_rails.js"

class Connection
  def initialize
    # Use native to avoid `uninitialized constant Connection::WebSocketRails`
    @dispatcher = WebSocketRails::WebSocketRails.new("localhost:3000/websocket")

    @game_state_channel = @dispatcher.subscribe("game_state")
    @game_state_channel.bind("full_update") { |message| $$.console.log(data) }
  end

  def update_client(message)
    $$.console.log(self)
    @dispatcher.trigger("client_updated", {:message => message})
  end

  private

  def process_action
  end
end
