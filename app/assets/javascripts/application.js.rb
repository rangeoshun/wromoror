require 'opal'
require 'opal_ujs'
require 'opal-jquery'
require 'turbolinks'
require 'client.js'

$$[:document].addEventListener(:DOMContentLoaded, -> {
  client = $$.client = Client.new
  client.ability_message = "Foo"
  client.message = "Bar"
  client.score = 100
})
