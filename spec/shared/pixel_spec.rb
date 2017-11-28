require 'matrix'
require 'shared/pixel'

RSpec.describe Pixel do
  context "by default" do
    it "instantiates without errors" do
      pixel = Pixel.new
      expect(pixel).to be_truthy
    end

    it "is not visible" do
      pixel = Pixel.new
      expect(pixel.is_visible).to eq false
    end

    it "is black" do
      pixel = Pixel.new
      expect(pixel.r).to eq 0
      expect(pixel.g).to eq 0
      expect(pixel.b).to eq 0
    end

    it "has the coordinates of 0:0" do
      pixel = Pixel.new
      expect(pixel.vector).to eq Vector[0, 0]
    end

    it "can return it's color in hex string" do
      pixel = Pixel.new
      expect(pixel.to_hex).to eq "#000000"
    end
  end

  context "color components" do
    it "are settable during instantiation" do
      pixel = Pixel.new(nil, 1, 2, 3)

      expect(pixel.r).to eq 1
      expect(pixel.g).to eq 2
      expect(pixel.b).to eq 3
    end

    it "are settable after instantiation" do
      pixel = Pixel.new
      pixel.r = 1
      pixel.g = 2
      pixel.b = 3

      expect(pixel.r).to eq 1
      expect(pixel.g).to eq 2
      expect(pixel.b).to eq 3
    end

    it "are limited for range 0..255" do
      pixel = Pixel.new(nil, -1, -1, -1)

      expect(pixel.r).to eq 0
      expect(pixel.g).to eq 0
      expect(pixel.b).to eq 0

      pixel = Pixel.new(nil, 256, 256, 256)

      expect(pixel.r).to eq 255
      expect(pixel.g).to eq 255
      expect(pixel.b).to eq 255
    end

    it "are represented in the hex format" do
      pixel = Pixel.new(nil, 256, 256, 256)

      expect(pixel.to_hex).to eq "#ffffff"
    end
  end
end
