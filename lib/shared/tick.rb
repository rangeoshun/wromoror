require 'thread'
require 'rails/all'

class Tick
  attr_reader :thread, :is_ticking, :game

  def initialize(game = nil)
    @game = game
    @speed = 30
    @on_before_tick = []
    @on_tick = []
    @on_after_tick = []
    @thread = nil
    @is_ticking = false

    WebsocketRails.logger.info "Tick initialized"
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
    if !@thread.nil? then stop end

    delay = 1 / @speed
    @is_ticking = true

    @thread = Thread.new(self) { |tick|
      WebsocketRails.logger.info "Tick started on: #{Thread.current}"
      # TODO: Find out how to handle exceptions
      loop {
        tick.step
        sleep 1
        # sleep delay
      }
    }
  end

  def stop
    @thread.kill
    @thread = nil
    @is_ticking = false
    WebsocketRails.logger.info "Tick stopped on thread: #{@thread}"
  end

  def handle_callbacks(queue = [])
    players = @game.players
    points = @game.points

    queue.map { |callback|
      callback[] ? callback : nil
    }.reject { |callback| callback.nil? }
  end

  def step
    if @game.is_paused then return end

    @on_before_tick = handle_callbacks(@on_before_tick)
    @on_tick = handle_callbacks(@on_tick)
    @on_after_tick = handle_callbacks(@on_after_tick)
  end
end
