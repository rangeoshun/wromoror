require 'native'

class Client
  def initialize
    @mainView = $$.document.querySelector('#main')
    @scoreBoard = $$.document.querySelector('#scores')
    @scoreHUD = $$.document.querySelector('.status > .score')
    @messageHUD = $$.document.querySelector('.status > .message')
    @abilitiesHUD = $$.document.querySelector('.status > .abilities')
    @dpad = $$.document.querySelector('#dpad')
  end
end
