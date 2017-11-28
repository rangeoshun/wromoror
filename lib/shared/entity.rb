require 'uuidtools'
require 'shared/updatable'

class Entity
  attr_reader :id, :type, :vector, :is_alive, :name

  def initialize(game = nil, type = "")
    @id = UUIDTools::UUID.random_create.to_s
    @type = Updatable.new(type)
    @vector = Updatable.new(Vector[0, 0])
    @name = Updatable.new("")
    @is_alive = Updatable.new(true)
    @is_updated = true
  end

  def id=(_) end
  def type=(_) end

  def vector=(new_vector)
    @vector.value = new_vector ? new_vector : Vector[0, 0]
    @is_updated = @is_updated || @vector.is_updated
  end

  def is_alive=(new_state)
    @is_alive.value = new_state ? true : false
    @is_updated = @is_updated || @is_alive.is_updated
  end

  def name=(new_name)
    @name.value = new_name.to_s
    @is_updated = @is_updated || @name.is_updated
  end

  def full_hash
    {
      "id" => @id,
      "type" => @type.peek,
      "vector" => @vector.peek,
      "is_alive" => @is_alive.peek,
      "name" => @name.peek,
    }
  end

  def diff_hash
    diff = {
      "id" => @id,
    }

    if @type.is_updated then diff["type"] = @type.value end
    if @vector.is_updated then diff["vector"] = @vector.value end
    if @is_alive.is_updated then diff["is_alive"] = @is_alive.value end
    if @name.is_updated then diff["name"] = @name.value end

    diff
  end
end
