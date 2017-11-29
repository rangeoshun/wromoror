require "native"

class Setup
  def initialize(client)
    @client = client

    @DEFAULT_NAME = "UNNAMED"
    @LEGAL_NAME = $$.RegExp("[a-zA-Z0-9]|-|_|'|", "g")

    @name_input = $$.document.querySelector("#name")

    @name_input.addEventListener(:keydown, handle_name_change)
  end

  def normalize(name = "")
    name[0...15].match(@LEGAL_NAME)
  end

  def handle_name_change(event)
    $$.console.log(event)
    if @client.state != 'setup' then return end

    name = event.target.value || ""
    @client.change_name(normalize(name))

    if ev.keyCode == 13
      @client.go_play
    end
  end
end
