require "uuidtools"

class Player
  def initialize(connection)
    @id = UUIDTools::UUID.random_create
    @score = 0
    @connection = connection
  end

  def manifest(entity)
    @entity = entity
  end
end
