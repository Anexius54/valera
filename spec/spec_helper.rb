require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/lib/game.rb'
  add_filter '/lib/menu.rb'
end

SimpleCov.minimum_coverage 90
