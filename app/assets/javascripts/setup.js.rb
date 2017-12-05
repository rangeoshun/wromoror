require "native"

require "name_input.js"
require "color_picker.js"

class Setup
  def initialize(client)
    @client = client

    @color_picker = ColorPicker.new(client)
    @name_input = NameInput.new(client)
  end
end
