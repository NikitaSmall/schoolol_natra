require "rubygems"
require "bundler/setup"
require "sinatra"
require "sinatra/base"

require "sinatra/reloader"

require File.join(File.dirname(__FILE__), "environment")

require File.join(File.dirname(__FILE__), "routes/index")
require File.join(File.dirname(__FILE__), "routes/products")
require File.join(File.dirname(__FILE__), "routes/orders")
require File.join(File.dirname(__FILE__), "routes/carts")

class SchoolApp < Sinatra::Base

  use Rack::Session::Cookie,
      key: 'rack.session',
      expire_after: 2592000,
      secret: 'nikitacrab'

  configure do
    set :views, "#{File.dirname(__FILE__)}/views"
    set :show_exceptions, :after_handler
  end

  configure :production, :development do
    enable :logging
  end

  helpers do
    # helper to quick access to cart in session in view
    def cart
      session[:cart]
    end
  end

  # registered routes for root page
  register Sinatra::SchoolApp::Routing::Index

  # registered routes for products
  register Sinatra::SchoolApp::Routing::Products

  # registered routes for orders
  register Sinatra::SchoolApp::Routing::Orders

  # register routes for cart actions
  register Sinatra::SchoolApp::Routing::Carts
end
