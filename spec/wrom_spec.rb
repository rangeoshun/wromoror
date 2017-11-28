require 'wrom'

RSpec.describe Wrom, 'core' do
  it "instantiates without errors" do
    wrom = Wrom.new
    expect(wrom).to be_truthy
  end

  context "reports health check" do
    it "'OK' if all's good" do
      wrom = Wrom.new
      expect(wrom.check_state).to eq "OK"
    end
  end
end
