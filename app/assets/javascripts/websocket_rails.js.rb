require "channel.js"
require "event.js"
require "http_connection.js"
require "websocket_connection.js"

###
# WebsocketRails JavaScript Client
#
# Setting up the dispatcher:
#   var dispatcher = new WebSocketRails('localhost:3000/websocket');
#   dispatcher.on_open = function() {
#     // trigger a server event immediately after opening connection
#     dispatcher.trigger('new_user',{user_name: 'guest'});
#   })
#
# Triggering a new event on the server
#   dispatcherer.trigger('event_name',object_to_be_serialized_to_json);
#
# Listening for new events from the server
#   dispatcher.bind('event_name', function(data) {
#     console.log(data.user_name);
#   });
#
# Stop listening for new events from the server
#   dispatcher.unbind('event')
###
module WebSocketRails
  class WebSocketRails
    attr_accessor :state, :on_open

    def initialize(url, use_websockets = true)
      @url = url
      @use_websockets = use_websockets

      @state = "standby"
      @callbacks = {}
      @channels = {}
      @queue = {}
      @connection = nil

      connect()
    end

    def connection
      @connection
    end

    def connect
      @state = "connecting"

      if !supports_websockets() or !@use_websockets
        @connection = HttpConnection.new(@url, self)
      else
        @connection = WebSocketConnection.new(@url, self)
      end

      @connection.new_message = @new_message
    end

    def disconnect
      if @connection
        @connection.close()
        @connection.connection = nil
        @connection = nil
      end

      @state = 'disconnected'
    end

    # Reconnects the whole connection,
    # keeping the messages queue and its' connected channels.
    #
    # After successfull connection, this will:
    # - reconnect to all channels, that were active while disconnecting
    # - resend all events from which we haven't received any response yet
    def reconnect
      old_connection_id = @connection.connection_id

      disconnect()
      connect()

      # Resend all unfinished events from the previous connection.
      @queue.each do |key, event|
        if event.connection_id == old_connection_id && !event.is_result()
          trigger_event(event)
        end
      end

      reconnect_channels()
    end

    def new_message(data)
      for socket_message in data
        event = Event.new(socket_message)

        if event.is_result
          @queue[event.id].run_callbacks(event.success, event.data)
          @queue[event.id] = nil
        elsif event.is_channel
          dispatch_channel(event)
        elsif event.is_ping
          pong
        else
          dispatch(event)
        end

        if @state == 'connecting' and event.name == 'client_connected'
          connection_established(event.data)
        end
      end
    end

    def connection_established(data)
      @state = 'connected'
      @connection.connection_id = data[:connection_id]
      @connection.flush_queue()

      if @on_open
        @on_open.call(nil, data)
      end
    end

    def bind(event_name, callback)
      @callbacks[event_name] |= []
      @callbacks[event_name].push(callback)
    end

    def unbind(event_name)
      @callbacks[event_name] = nil
    end

    def trigger(event_name, data, success_callback, failure_callback)
      event = Event.new(
        [event_name, data, @connection.connection_id],
        success_callback,
        failure_callback
      )

      trigger_event(event)
    end

    def trigger_event(event)
      @queue[event.id] |= event # Prevent replacing an event that has callbacks stored

      if @connection then @connection.trigger(event) end

      event
    end

    def dispatch(event)
      if !@callbacks[event.name] then return end

      for callback in @callbacks[event.name]
        callback event.data
      end
    end

    def subscribe(channel_name, success_callback, failure_callback)
      if !@channels[channel_name]
        channel = Channel.new(channel_name, self, false, success_callback, failure_callback)
        @channels[channel_name] = channel

        channel
      else
        @channels[channel_name]
      end
    end

    def subscribe_private(channel_name, success_callback, failure_callback)
      if !@channels[channel_name]
        channel = Channel.new(channel_name, self, true, success_callback, failure_callback)
        @channels[channel_name] = channel

        channel
      else
        @channels[channel_name]
      end
    end

    def unsubscribe(channel_name)
      if !@channels[channel_name] then return end

      @channels[channel_name].destroy()
      @channels[channel_name] = nil
    end

    def dispatch_channel(event)
      if !@channels[event.channel] then return end

      @channels[event.channel].dispatch event.name, event.data
    end

    def supports_websockets
      Native(`typeof WebSocket == 'function' || typeof WebSocket == 'object'`)
    end

    def pong
      pong = Event.new(['websocket_rails.pong', {}, @connection.connection_id])
      @connection.trigger(pong)
    end

    def is_connection_stale
      @state != 'connected'
    end

    # Destroy and resubscribe to all existing @channels.
    def reconnect_channels
      @channels.each do |name, channel|
        callbacks = channel.callbacks
        channel.destroy()
        @channels[name] = nil

        channel =
          if channel.is_private
            subscribe_private(name)
          else
            subscribe(name)
          end

        channel.callbacks = callbacks
        channel
      end
    end
  end
end
