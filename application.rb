require "rubygems"
require "bundler/setup"
require "sinatra"

require "sinatra/reloader"

require File.join(File.dirname(__FILE__), "environment")

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  set :show_exceptions, :after_handler
end

configure :production, :development do
  enable :logging
end

helpers do
  # add your helpers here
end

# root page
get "/" do
  slim :index, locals: { name: 'nikita' }
end

get "/products/create" do
  @product = Product.new
  slim :"products/create", locals: { product: @product }
end

post "/products" do
  @product = Product.new(params[:product])

  if @product.save
    redirect '/'
  else
    slim :"products/create", locals: { product: @product, errors: @product.errors }
  end
end
