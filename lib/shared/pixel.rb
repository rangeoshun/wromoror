require 'shared/matrix'
require 'shared/byte'

class Pixel
  attr_accessor :is_visible, :vector
  attr_reader :r, :g, :b

  def initialize(is_visible = false, r = 0, g = 0, b = 0, vector = nil)
    @is_visible = false
    @r = Byte.new(r)
    @g = Byte.new(g)
    @b = Byte.new(b)
    @vector = vector || Vector[0, 0]
  end

  def r=(value)
    @r = Byte.new(value)
  end

  def g=(value)
    @g = Byte.new(value)
  end

  def b=(value)
    @b = Byte.new(value)
  end

  def color=(colorAry = [])
    @r = Byte.new((colorAry[0] * Byte::MAX).round)
    @g = Byte.new((colorAry[1] * Byte::MAX).round)
    @b = Byte.new((colorAry[2] * Byte::MAX).round)
  end

  def to_hex
    "##{@r.to_hex}#{@g.to_hex}#{@b.to_hex}"
  end
end
