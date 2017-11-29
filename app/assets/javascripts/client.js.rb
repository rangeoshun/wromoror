require "native"
require "setup.js"

class Client
  attr_reader :state

  def initialize
    @ability_status = $$.document.querySelector(".status > .abilities")
    @dpad = $$.document.querySelector("#dpad")
    @main_view = $$.document.querySelector("#main")
    @message_status = $$.document.querySelector(".status > .message")
    @score_board = $$.document.querySelector("#scores")
    @score_status = $$.document.querySelector(".status > .score")
    @go_play_button = $$.document.querySelector("#goPlay")

    @setup = Setup.new(self)

    @ability_message = ""
    @message = ""
    @score = 0
    @show_scores
    @state = "setup"

    @go_play_button.addEventListener(:click) { go_play }
  end

  def go_play
    $$.console.log("go_play")
  end

  def change_name(name = "")
    $$.console.log(name)
  end

  def ability_message=(text = "")
    @ability_message = text
    @ability_status.innerText = text
  end

  def message=(text = "")
    @message = text
    @message_status.innerText = text
  end

  def score=(value = 0)
    @score = value
    @score_status.innerText = value
  end
end
