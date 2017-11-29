# Require the opal runtime and core library
require 'opal'
# For Rails 5.1 and above, otherwise use 'opal_ujs'
require 'opal_ujs'
# Require of JS libraries will be forwarded to sprockets as is
# require 'turbolinks'
# a Ruby equivalent of the require_tree Sprockets directive is available
# require_tree '.'

require 'client.js'

# puts "hello world!"
# pp hello: :world
# require 'console'
# $console.log %w[Hello world!]

# # == Use Native to wrap native JS objects, $$ is preconfigured to wrap `window`
# require 'native'
# $$.alert "Hello world!"

# # == Do some DOM manipulation with jQuery
# require 'opal-jquery'

$$[:document].addEventListener(:DOMContentLoaded, -> {
  client = $$.client = Client.new
  client.ability_message = "Foo"
  client.message = "Bar"
  client.score = 100
})
