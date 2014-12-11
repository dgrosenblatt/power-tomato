ENV['RACK_ENV'] = 'test'
require_relative '../server'

require 'rspec'
require 'capybara/rspec'

Capybara.app = Sinatra::Application
