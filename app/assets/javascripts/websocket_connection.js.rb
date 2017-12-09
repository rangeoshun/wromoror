require "browser"
require "browser/event"
require "browser/socket"

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

      @connection = Browser::Socket.new @url
      @connection.on(:message) { |event| on_message(JSON.parse(event.data)) }
      @connection.on(:close) { |event| on_close(event) }
      @connection.on(:error) { |event| on_error(event) }
    end

    def close
      @connection.close
    end

    def send_event(event)
      super(event)
      @connection.send(event.serialize)
    end
  end
end
