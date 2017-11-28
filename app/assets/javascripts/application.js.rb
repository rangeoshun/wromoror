# Require the opal runtime and core library
require 'opal'

# For Rails 5.1 and above, otherwise use 'opal_ujs'
require 'opal_ujs'

# Require of JS libraries will be forwarded to sprockets as is
require 'turbolinks'

# a Ruby equivalent of the require_tree Sprockets directive is available
require_tree '.'

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

# # == Or access the DOM api directly
# $$[:document].addEventListener(:DOMContentLoaded, -> {
#   $$[:document].querySelector('body')[:innerHTML] = '<h1>Hello world!</h1>'
# })

Document.ready? do
  $$.client = Client.new
end
