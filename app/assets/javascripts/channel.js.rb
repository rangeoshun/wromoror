module WebSocketRails
  ###
  # The channel object is returned when you subscribe to a channel.
  #
  # For instance:
  #   var dispatcher = new WebSocketRails('localhost:3000/websocket');
  #   var awesome_channel = dispatcher.subscribe('awesome_channel');
  #   awesome_channel.bind('event', function(data) { console.log('channel event!'); });
  #   awesome_channel.trigger('awesome_event', awesome_object);
  #
  # If you want to unbind an event, you can use the unbind function :
  #   awesome_channel.unbind('event')
  ###
  class Channel
    def constructor(name, dispatcher, is_private = false, on_success, on_failure)
      @name = name
      @dispatcher = dispatcher
      @is_private = is_private
      @on_success = on_success
      @on_failure = on_failure

      @callbacks = {}
      @token = nil
      @queue = []

      if @is_private
        event_name = 'websocket_rails.subscribe_private'
      else
        event_name = 'websocket_rails.subscribe'
      end

      @connection_id = @dispatcher.connection.connection_id
      event = Event.new(
        [event_name, {data: {channel: @name}}, @connection_id],
        @success_launcher,
        @failure_launcher
      )

      @dispatcher.trigger_event(event)
    end

    def destroy
      if @connection_id == @dispatcher.connection.connection_id
        event_name = 'websocket_rails.unsubscribe'
        event = Event.new([event_name, {data: {channel: @name}}, @connection_id])
        @dispatcher.trigger_event(event)
      end

      @callbacks = {}
    end

    def bind(event_name, callback)
      @callbacks[event_name] |= []
      @callbacks[event_name].push(callback)
    end

    def unbind(event_name)
      @callbacks.delete(event_name)
    end

    def trigger(event_name, message)
      event = Event.new([event_name, {channel: @name, data: message, token: @token}, @connection_id])

      if !@token
        @queue.push(event)
      else
        @dispatcher.trigger_event(event)
      end
    end

    def dispatch(event_name, message)
      if event_name == 'websocket_rails.channel_token'
        @connection_id = @dispatcher.connection.connection_id
        @token = message['token']
        flush_queue()
      else
        if !@callbacks[event_name] then return end

        for callback in @callbacks[event_name]
          callback.call(nil, message)
        end
      end
    end

    def flush_queue
      for event in @queue
        @dispatcher.trigger_event(event)
      end

      @queue = []
    end

    private

    # using this method because @on_success will not be defined when the constructor is executed
    def success_launcher(data)
      if @on_success.nil? then return end

      @on_success.call(nil, data)
    end

    # using this method because @on_failure will not be defined when the constructor is executed
    def failure_launcher(data)
      if @on_failure.nil? then return end

      @on_failure.call(nil, data)
    end
  end
end
