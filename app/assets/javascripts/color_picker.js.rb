require "shared/matrix"
require "shared/colors"

class ColorPicker
  def initialize(client)
    @client = client
    @palette = Element.find("#color_palette")

    Colors::List.keys.each { |name|
      @palette.html += color_sample(name, Colors::to_hex(name))
    }

    $$.console.log(Vector[0, 1])
  end

  def color_sample(name, color)
    "<div
      id=\"#{name}_color\"
      data-name=\"#{name}\"
      class=\"color_sample\"
      style=\"background-color: #{color};\"
    >
        &nbsp;
    </div>"
  end
end
