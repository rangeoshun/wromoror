require "websocket_rails.js"

class Connection
  def initialize
    # Use native to avoid `uninitialized constant Connection::WebSocketRails`
    @dispatcher = WebSocketRails::WebSocketRails.new("localhost:3000/websocket")

    @dispatcher.subscribe("game_state")
  end

  private

  def process_action
  end
end
