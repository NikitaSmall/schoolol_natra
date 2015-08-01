require "rubygems"
require "bundler/setup"
require "sinatra"
require "sinatra/base"

require 'rack-flash'
require 'sinatra/redirect_with_flash'

require "sinatra/reloader"

require File.join(File.dirname(__FILE__), "environment")

require File.join(File.dirname(__FILE__), "routes/index")
require File.join(File.dirname(__FILE__), "routes/products")
require File.join(File.dirname(__FILE__), "routes/orders")
require File.join(File.dirname(__FILE__), "routes/carts")
require File.join(File.dirname(__FILE__), "routes/categories")

class SchoolApp < Sinatra::Base

  use Rack::Session::Cookie,
      key: 'rack.session',
      expire_after: 2592000,
      secret: 'nikitacrab'

  use Rack::Flash

  configure do
    set :views, "#{File.dirname(__FILE__)}/views"
    set :show_exceptions, :after_handler
  end

  configure :production, :development do
    enable :logging
  end

  helpers do
    # helpers to provide auth
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Speak, friend, and enter"'
      halt 401, "The Balrog of Morgoth! You shall not pass!\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
    end

    # helper for more easily redirect and beauty code
    def redirect_with_notice(url, notice)
      flash[:notice] = notice
      redirect url
    end

    # helper to quick access to cart in session in view
    def cart
      session[:cart]
    end

    # helper to show notices at main layout
    def notice
      flash[:notice]
    end
  end

  # registered routes for root page
  register Sinatra::SchoolApp::Routing::Index

  # registered routes for products
  register Sinatra::SchoolApp::Routing::Products

  # registered routes for categories
  register Sinatra::SchoolApp::Routing::Categories

  # registered routes for orders
  register Sinatra::SchoolApp::Routing::Orders

  # register routes for cart actions
  register Sinatra::SchoolApp::Routing::Carts
end
