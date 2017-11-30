require "/lib/shared/pixel"
require "/lib/shared/color_list"

class ColorPicker
  def initialize(client)
    @client = client
    @palette_input = Element.find("#colorPalette")
  end
end
