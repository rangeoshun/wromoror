require 'shared/entity'

class Point < Entity
  attr_reader :alive, :value, :type

  def initialize(game = nil)
    super(game)

    @alive = true
    @value = 10
    @type = "p"
  end
end
