require "shared/colors"

class User
  attr_accessor :name, :color

  DEFAULT_NAME = "UNNAMED"

  def initialize
    @name = DEFAULT_NAME
    @color = Colors::random
  end
end
