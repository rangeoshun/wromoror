require "opal-actioncable"

class GameChannel < ActionCable::Subscription
  def connected
    # perform on connection things
  end

  def disconnected
  end

  def received(data)
  end
end
