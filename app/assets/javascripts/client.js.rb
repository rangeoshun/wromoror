require 'native'

class Client
  def initialize
    @ability_status = $$.document.querySelector('.status > .abilities')
    @dpad = $$.document.querySelector('#dpad')
    @main_view = $$.document.querySelector('#main')
    @message_status = $$.document.querySelector('.status > .message')
    @score_board = $$.document.querySelector('#scores')
    @score_status = $$.document.querySelector('.status > .score')

    @ability_message = ""
    @message = ""
    @score = 0
    @show_scores
    @state = "screen" # "setup"
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
