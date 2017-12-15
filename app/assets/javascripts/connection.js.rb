require "opal-actioncable"
require "game_channel.js"

class Connection
  def initialize
    @consumer = ActionCable.createConsumer
    @consumer.subscriptions.create GameChannel
  end
end
