require 'shared/byte'

RSpec.describe Byte do
  context "by default" do
    it "can be instantiated" do
      byte = Byte.new
      expect(byte).to be_truthy
    end

    it "takes value 0" do
      byte = Byte.new
      expect(byte).to eq 0
    end

    it "takes value assigned at construction" do
      byte = Byte.new 1
      expect(byte).to eq 1
    end
  end

  context "#==" do
    it "compares it's own value as number" do
      expect(Byte.new == 0).to eq true
    end
  end

  context "#+" do
    it "adds the value to retained one" do
      byte = Byte.new
      expect(byte + 1).to eq 1
    end

    it "respects the maximum limit" do
      byte = Byte.new
      expect(byte + 256).to eq 255
    end
  end

  context "#-" do
    it "substracts the value to retained one" do
      byte = Byte.new 1
      expect(byte - 1).to eq 0
    end

    it "respects the minimum limit" do
      byte = Byte.new
      expect(byte - 1).to eq 0
    end
  end

  context "#to_hex" do
    it "converts value to a hex string" do
      byte = Byte.new 255
      expect(byte.to_hex).to eq "ff"
    end

    it "adds a '0' if value would be single digit in hex" do
      byte = Byte.new 15
      expect(byte.to_hex).to eq "0f"
    end
  end

  context "can also" do
    it "convert to be an integer" do
      byte = Byte.new 255
      expect(byte.to_i).to eq 255
    end

    it "be converted to string" do
      byte = Byte.new 255
      expect(byte.to_s).to eq "255"
    end
  end
end
