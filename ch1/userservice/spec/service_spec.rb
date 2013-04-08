require File.dirname(__FILE__) + '../service/*'
require 'spec'
require 'spec/interop/test'
require 'rack/test'

set :environment, :test
Test::Unit::TestCase.send :include, Rack::Test::Methods

def app
  Sinatra::Application
end

describe "service" do
  before(:each) do
    User.delete_all
  end

  describe "GET on api/v1/users/:id" do
    before(:each) do
      User.create(
        :name => 'maxim',
        :email => 'maxim@example.com',
        :password => 'pass',
        :bio => 'twer')
    end

    it 'should return a user by name' do
      get '/api/v1/users/maxim'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes['name'].should == 'maxim'
    end

    it 'should return a user with an email' do
      get '/api/v1/users/maxim'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes['email'].should == 'maxim@example.com'
    end

    it 'should return a user"s password"' do
      get '/api/v1/users/maxim'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes['password'].should == 'pass'
    end

    it 'should return a user with bio' do
      get '/api/v1/users/maxim'
      last_response.should be_ok
      attributes = JSON.parse(last_response.body)
      attributes['bio'].should == 'twer'
    end

    it 'should return a 404 for a user that doesn"t exist' do
      get '/api/v1/users/foo'
      last_response.status.should == 404
    end

  end
end
