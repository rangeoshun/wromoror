require 'shared/updatable'

RSpec.describe Updatable do
  context "is instantiable" do
    it "without crashing" do
      expect(Updatable.new).to be_truthy
    end

    it "with value passed" do
      expect(Updatable.new "Foo").to be_truthy
    end

    it "with the flag is_updated value true" do
      updatable = Updatable.new

      expect(updatable.is_updated).to eq true
    end
  end

  context "value" do
    it "can read and marked so" do
      updatable = Updatable.new
      updatable.value

      expect(updatable.is_updated).to eq false
    end

    it "can be peeked without marking" do
      updatable = Updatable.new

      expect(updatable.peek).to eq nil
      expect(updatable.is_updated).to eq true
    end

    it "can be updated and is marked so" do
      updatable = Updatable.new
      updatable.value
      updatable.value = "Foo"

      expect(updatable.is_updated).to eq true
    end

    it "does not get marked if ==" do
      updatable = Updatable.new
      updatable.value
      updatable.value = nil

      expect(updatable.is_updated).to eq false
    end
  end

  context "can be" do
    it "compared without getting the value" do
      updatable = Updatable.new

      expect(updatable == nil).to eq true
    end

    it "checked for nilness" do
      updatable = Updatable.new

      expect(updatable.nil?).to eq true
    end
  end
end
