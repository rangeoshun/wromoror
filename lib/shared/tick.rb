require 'rails/all'

class Tick
  attr_reader :thread, :is_ticking

  def initialize(game = nil)
    @game = game
    @speed = 30
    @on_before_tick = []
    @on_tick = []
    @on_after_tick = []
    @thread = nil
    @is_ticking = false

    Rails.logger.info "Game initialized"
  end

  def on_before_tick=(callback = nil)
    if callback.nil? then return end

    @on_before_tick.push(callback)
  end

  def on_tick=(callback = nil)
    if callback.nil? then return end

    @on_before_tick.push(callback)
  end

  def on_after_tick=(callback = nil)
    if callback.nil? then return end

    @on_before_tick.push(callback)
  end

  def start
    delay = 1 / @speed
    @is_ticking = true
    Rails.logger.info "Tick started"
    @thread = Thread.new do
      loop do
        sleep delay
        Rails.logger.info "Tick"
        step.call()
      end
    end
  end

  def stop
    @thread.kill
    @thread = nil
    @is_ticking = false
  end

  def handle_callbacks(queue = [])
    players = @game.players
    points = @game.points

    queue.each do |callback|
      need_remove = callback.call(players, points)
      if need_remove then queue.delete(callback) end
    end
  end

  def step
    if @game.paused then return end

    handle_callbacks(@on_before_tick)
    handle_callbacks(@on_tick)
    handle_callbacks(@on_after_tick)
  end
end
