class Byte
  @@MIN = 0
  @@MAX = 255

  def initialize(value = 0)
    @value = limit(value.to_i)
  end

  def ==(other)
    @value.to_i == other.to_i
  end

  def +(value)
    Byte.new(limit(@value + value))
  end

  def -(value)
    Byte.new(limit(@value - value))
  end

  def to_i
    @value.to_i
  end

  def to_s
    @value.to_s
  end

  def to_hex
    hex = @value.to_s(16)
    hex.length == 1 ? "0#{hex}" : hex
  end

  private

  def limit(value)
    value > @@MAX ? @@MAX : value < @@MIN ? @@MIN : value
  end
end
