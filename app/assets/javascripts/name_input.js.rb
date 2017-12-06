class NameInput
  LEGAL_NAME = /\w/

  def initialize(client)
    @client = client

    @name_input = Element.find("#name")
    @name_input.value = client.user.name
    @name_input.on(:keyup) { |event| handle_name_change(event) }
  end

  def normalize(name = "")
    name[0..15].chars.select { |char| char.match(LEGAL_NAME) }.join
  end

  def handle_name_change(event)
    if @client.state != "setup" then return end

    name = normalize(event.target.value || "")
    @client.change_name(name)
    @name_input.value = name

    if event.which == 13
      @client.go_play
    end
  end
end
