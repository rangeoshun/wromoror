require "shared/pixel"
# require "shared/color_list"

color_sampler = Pixel.new

class ColorPicker
  def initialize(client)
    @client = client
    @palette_input = Element.find("#colorPalette")

    color_list.each { |name, colorAry|
      @palette_input.innerHTML += color_sample(name, colorAry)
    }
  end

  def color_sample(name, colorAry)
    "<div
      id=\"#{name}-color\"
      data-name=\"#{name}\"
      class=\"color-sample\"
      style=\"background-color: #{color_sampler.color(colorAry).to_hex};\"
    >
        &nbsp;
    </div>"
  end
end
