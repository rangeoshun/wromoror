require 'websocket_rails/main'

class Connection
  def initialize
    # Use native to avoid `uninitialized constant Connection::WebSocketRails`
    @socket = Native(`new WebSocketRails('localhost:3000/websocket')`)
    $$.console.log(@socket)
  end

  private

  def process_action
  end
end
