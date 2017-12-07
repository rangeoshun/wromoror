require "abstract_connection.js"

module WebSocketRails
  class WebSocketConnection < AbstractConnection
    @connection_type = 'websocket'

    def initialize(url, dispatcher)
      super(dispatcher)

      if url.match(/^wss?:\/\//)
        print "WARNING: Using connection urls with protocol specified is deprecated"
      elsif $$.location.protocol == 'https:'
        @url = "wss://#{url}"
      else
        @url = "ws://#{url}"
      end

      @connection = Native("new WebSocket(\"#{@url}\")")
      @connection.onmessage = lambda { |event| on_message(JSON.parse(event[:data])) }
      @connection.onclose = lambda { |event| on_close(event) }
      @connection.onerror = lambda { |event| on_error(event) }
    end

    def close
      @connection.close()
    end

    def send_event(event)
      super(event)
      @connection.send(event.serialize())
    end
  end
end
