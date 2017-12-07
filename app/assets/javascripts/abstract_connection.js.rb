require "event.js"

###
#  Abstract Interface for the WebSocketRails client.
###
module WebSocketRails
  class AbstractConnection
    def initialize(dispatcher)
      @dispatcher = dispatcher
      @message_queue = []
    end

    def close
    end

    def trigger(event)
      if @dispatcher.state != 'connected'
        @message_queue.push(event)
      else
        send_event(event)
      end
    end

    def send_event(event)
      # Events queued before connecting do not have the correct
      # connection_id set yet. We need to update it before dispatching.
      if !@connection_id.nil?
        event.connection_id = @connection_id
      end
    end

    def on_close(event)
      if @dispatcher && @dispatcher.connection == self
        close_event = Event.new(['connection_closed', event])
        @dispatcher.state = 'disconnected'
        @dispatcher.dispatch(close_event)
      end
    end

    def on_error(event)
      if @dispatcher && @dispatcher.connection == self
        error_event = Event.new(['connection_error', event])
        @dispatcher.state = 'disconnected'
        @dispatcher.dispatch(error_event)
      end
    end

    def on_message(event_data)
      if @dispatcher && @dispatcher.connection == self
        @dispatcher.new_message(event_data)
      end
    end

    def new_message=(message)
      @new_message = message
    end

    def connection_id=(id)
      @connection_id = id
    end

    def flush_queue
      @message_queue.each do |event|
        trigger(event)
      end

      @message_queue = []
    end
  end
end
