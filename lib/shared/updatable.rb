class Updatable
  attr_reader :is_updated

  def initialize(value = nil)
    @is_updated = true
    @value = value
  end

  def value
    @is_updated = false
    @value
  end

  def peek
    @value
  end

  def value=(new_value)
    if @value == new_value
      return
    end

    @value = new_value
    @is_updated = true
  end

  def ==(other)
    @value == other
  end

  def nil?
    @value.nil?
  end
end
