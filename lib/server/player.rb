require "uuidtools"

class Player
  def initialize(connection = nil)
    @id = UUIDTools::UUID.random_create.to_s
    @score = 0
    @connection = connection
  end

  def manifest(entity)
    @entity = entity
  end
end
