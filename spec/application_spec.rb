require "#{File.dirname(__FILE__)}/spec_helper"

describe 'main application' do
  include Rack::Test::Methods

  def app
    SchoolApp.new
  end

  it 'shows the default index page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should protect from empty checkout' do
    get '/checkout'
    expect(last_response).to be_redirect
  end

  it 'should show checkout page' do
    get '/checkout', {}, 'rack.session' => { :cart => { 1 => 2 } } # this is a session true name for tests
    expect(last_response).to be_ok
  end

  it 'should have more specs'
end