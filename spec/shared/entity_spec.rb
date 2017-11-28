require 'matrix'
require 'shared/entity'

RSpec.describe Entity do
  context "is instantiable" do
    it "without crashing" do
      expect(Entity.new).to be_truthy
    end

    it "and generates an id for itself" do
      entity = Entity.new

      expect(entity.id).to be_truthy
      expect(entity.id).to be_instance_of String
    end

    it "and has no type by default" do
      entity = Entity.new

      expect(entity.type).to eq ""
    end

    it "with vector 0,0" do
      entity = Entity.new

      expect(entity.vector).to eq Vector[0, 0]
    end

    it "and is alive" do
      entity = Entity.new

      expect(entity.is_alive).to eq true
    end

    it "and has no name" do
      entity = Entity.new

      expect(entity.name).to eq ""
    end
  end

  context "instance" do
    it "has a readonly id" do
      entity = Entity.new
      id = entity.id
      entity.id = "foo"

      expect(entity.id).to eq id
    end

    it "has updatable vector" do
      entity = Entity.new
      entity.vector = Vector[0, 1]

      expect(entity.vector).to eq Vector[0, 1]
    end

    it "can be killed and resurrected" do
      entity = Entity.new
      entity.is_alive = false

      expect(entity.is_alive).to eq false
    end

    it "can be renamed" do
      entity = Entity.new
      entity.name = "Bill"

      expect(entity.name).to eq "Bill"
    end

    it "has a readonly type" do
      entity = Entity.new(nil, "foo")
      entity.type = "bar"

      expect(entity.type).to eq "foo"
    end

    it "can generate a full hash" do
      entity = Entity.new(nil, "foo")
      entity.name = "Bob"
      entity.vector = Vector[0, 1]

      expect(entity.full_hash).to eq({
        "id" => entity.id,
        "type" => entity.type.peek,
        "vector" => entity.vector.peek,
        "is_alive" => entity.is_alive.peek,
        "name" => entity.name.peek,
      })
    end

    it "can generate a diff hash" do
      entity = Entity.new(nil, "foo")

      expect(entity.diff_hash).to eq({
        "id" => entity.id,
        "type" => entity.type.peek,
        "vector" => entity.vector.peek,
        "is_alive" => entity.is_alive.peek,
        "name" => entity.name.peek,
      })
    end
  end
end
