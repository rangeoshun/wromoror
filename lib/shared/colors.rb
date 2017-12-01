require 'shared/pixel'

class Colors
  Sampler = Pixel.new

  List = {
    "purple" => [0.8, 0.2, 0.8],
    "magenta" => [1, 0.5, 1],
    "red" => [1, 0.2, 0.2],
    "red_light" => [1, 0.5, 0.5],
    "orange" => [1, 0.5, 0.2],
    "orange_light" => [1, 0.6, 0.3],
    "gold" => [1, 0.8, 0],
    "yellow" => [1, 1, 0.5],
    "green" => [0.2, 1, 0.2],
    "green_light" => [0.5, 1, 0.5],
    "blue" => [0.2, 0.2, 1],
    "blue_light" => [0.5, 0.5, 1],
    "cyan" => [0.2, 0.8, 0.8],
    "cyan_light" => [0.5, 1, 1],

    "gray" => [0.5, 0.5, 0.5],
    "gray_light" => [0.8, 0.8, 0.8],
    "white" => [1, 1, 1],
  }

  def self.to_hex(name)
    Sampler.color = List[name]
    Sampler.to_hex
  end
end
