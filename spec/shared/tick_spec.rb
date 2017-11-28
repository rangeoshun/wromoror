require 'shared/tick'

class GameMock
  attr_reader :players, :points, :paused

  def initialize
    @players = []
    @points = []
    @paused = false
  end
end

describe Point do
  context "is instantiable" do
    it "without crashing" do
      expect(Tick.new).to be_truthy
    end
  end

  before(:each) do
    @game = GameMock.new
    @counter = 0

    def callback(players = nil, points = nil)
      if !players.nil? then @counter += 1 end
      if !points.nil? then @counter += 1 end

      if players.nil? and points.nil? then @counter = -1 end
    end
  end

  context "can" do
    it "handles on_before_tick callbacks" do
      tick = Tick.new(@game)

      tick.on_before_tick = method(:callback)
      tick.step
      expect(@counter).to eq 2
    end

    it "handles on_tick callbacks" do
      tick = Tick.new(@game)

      tick.on_tick = method(:callback)
      tick.step
      expect(@counter).to eq 2
    end

    it "handles on_after_tick callbacks" do
      tick = Tick.new(@game)

      tick.on_after_tick = method(:callback)
      tick.step
      expect(@counter).to eq 2
    end

    it "start and stop a new thread to manage tick loop " do
      tick = Tick.new
      thread = tick.start(method(:callback))

      expect(tick.thread).to be_instance_of Thread

      sleep 1
      expect(@counter).to eq -1

      tick.stop

      expect(tick.thread).to be nil
      expect(thread.status).to be false
    end
  end
end
