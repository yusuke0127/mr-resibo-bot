require 'rack/test'
require 'rspec'
require 'pry'

require File.expand_path "../../lib/app", __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end
end

RSpec.configure { |c| c.include RSpecMixin } 
