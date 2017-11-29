require "setup.js"

class Client
  attr_reader :state

  def initialize
    @ability_status = Element.find(".status > .abilities")
    @dpad = Element.find("#dpad")
    @main_view = Element.find("#main")
    @message_status = Element.find(".status > .message")
    @score_board = Element.find("#scores")
    @score_status = Element.find(".status > .score")
    @go_play_button = Element.find("#goPlay")

    @setup = Setup.new(self)

    @ability_message = ""
    @message = ""
    @score = 0
    @show_scores
    @state = "setup"

    @go_play_button.on(:click) { go_play }
  end

  def go_play
    $$.console.log("go_play")
  end

  def change_name(name = "")
    $$.console.log(name)
  end

  def ability_message=(text = "")
    @ability_message = text
    @ability_status.text = text
  end

  def message=(text = "")
    @message = text
    @message_status.text = text
  end

  def score=(value = 0)
    @score = value
    @score_status.text = value
  end
end
