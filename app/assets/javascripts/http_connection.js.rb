require "abstract_connection.js"

module WebSocketRails
  ###
  # HTTP Interface for the WebSocketRails client.
  ###
  class HttpConnection < AbstractConnection
    @connection_type = 'http'

    @@HTTP_FACTORIES = [
      lambda { Native(`window.XDomainRequest && new XDomainRequest()`) },
      lambda { Native(`window.XMLHttpRequest && new XMLHttpRequest()`) },
      lambda { Native(`window.ActiveXObject && new ActiveXObject("Msxml2.XMLHTTP")`) },
      lambda { Native(`window.ActiveXObject && new ActiveXObject("Msxml3.XMLHTTP")`) },
      lambda { Native(`window.ActiveXObject && new ActiveXObject("Microsoft.XMLHTTP")`) },
    ]

    def initialize(url, dispatcher)
      super(dispatcher)
      @url = "http://#{url}"
      @connection = create_xml_http_object()
      @last_pos = 0

      $$.console.log(@connection)

      begin
        @connection.onreadystatechange = parse_stream
        @connection.addEventListener(:load) { on_close() }
      rescue
        @connection.onprogress = parse_stream
        @connection.onload = on_close
        # set this as 3 always for parse_stream as the object does not have this property at all
        @connection.readyState = 3
      end

      @connection.open("GET", @url, true)
      @connection.send()
    end

    def close
      @connection.abort()
    end

    def send_event(event)
      super(event)
      post_data(event.serialize())
    end

    private

    def post_data(payload)
      HTTP.post(@url, {
        :data => {
          :client_id => @connection_id,
          :data => payload,
        },
        :success => nil,
      })
    end

    def create_xml_http_object
      xmlhttp = false

      for factory in @@HTTP_FACTORIES
        begin
          xmlhttp = factory.call()
        rescue
          next
        end

        if xmlhttp then break end
      end

      xmlhttp
    end

    def parse_stream
      if @connection.readyState == 3
        data = @connection.responseText.last(@last_pos)
        @last_pos = @connection.responseText.length
        data = data.sub(/\]\]\[\[/, "],[")

        begin
          event_data = JSON.parse(data)
          on_message(event_data)
        rescue Error
          print Error.to_s
        end
      end
    end
  end
end
