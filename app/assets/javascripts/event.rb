module WebSocketRails
  ###
  # The Event object stores all the relevant event information.
  ###
  class Event
    def constructor(data, success_callback, failure_callback)
      @name = data[0]
      @success_callback = success_callback
      @failure_callback = failure_callback

      attribute = data[1]

      if attribute
        @id = attribute['id'] ? attribute['id'] : (((1 + Math.random()) * 0x10000) | 0)
        @channel = attribute.channel ? attribute.channel : nil
        @data = attribute.data ? attribute.data : attribute
        @token = attribute.token ? attribute.token : nil
        @connection_id = data[2]

        if attribute.success
          @result = true
          @success = attribute.success
        end
      end
    end

    def is_channel
      !@channel.nil?
    end

    def is_result
      !@result.nil?
    end

    def is_ping
      @name == 'websocket_rails.ping'
    end

    def serialize
      JSON.stringify([@name, attributes()])
    end

    def attributes
      {
        :id => @id,
        :channel => @channel,
        :data => @data,
        :token => @token,
      }
    end

    def run_callbacks(success, result)
      @success = success
      @result = result

      if @success == true
        @success_callback.call(nil, @result)
      else
        @failure_callback.call(nil, @result)
      end
    end
  end
end
