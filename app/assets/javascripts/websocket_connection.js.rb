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

      @connection = Browser::Socket.new @url do
        on :open do |event| $$.console.log(event) end

        on :message do |event| on_message(JSON.parse(event[:data])) end

        on :close do |event| on_close(event) end

        on :error do |event| on_error(event) end
      end
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
