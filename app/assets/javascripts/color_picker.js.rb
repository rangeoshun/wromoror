require "shared/colors"

class ColorPicker
  def initialize(client)
    @client = client
    @palette = Element.find("#color_palette")

    draw_samples()
  end

  def draw_samples
    @palette.html = ""

    Colors::List.keys.each { |name|
      @palette.html += color_sample(name, Colors::to_hex(name))
    }

    @palette.find(".color_sample").on(:click) { |event| handle_color_select(event) }
  end

  def handle_color_select(event)
    @client.change_color(event.target.data('name'))
    draw_samples()
  end

  def color_sample(name, color)
    "<div
      id=\"#{name}_color\"
      data-name=\"#{name}\"
      class=\"color_sample#{name == @client.user.color ? " selected" : ""}\"
      style=\"background-color: #{color};\"
    >
        &nbsp;
    </div>"
  end
end
