require 'shared/point'

RSpec.describe Point do
  context "is instantiable" do
    it "without crashing" do
      expect(Point.new).to be_truthy
    end

    it "and is alive" do
      point = Point.new
      expect(point.alive).to eq true
    end

    it "and has the value of 10" do
      point = Point.new
      expect(point.value).to eq 10
    end

    it "as type \"p\"" do
      point = Point.new
      expect(point.type).to eq "p"
    end
  end
end
