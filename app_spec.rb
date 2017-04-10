require_relative './app.rb'
require 'rspec'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.default_formatter = 'doc'
  config.order = :random

  def app
    Sinatra::Application
  end
end

describe 'Sinatmdiff' do
  context "GET '/'" do
    it 'should return index.html' do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.status).to eq(200)
      expect(last_response.body).to_not eq('')
    end
  end
end
