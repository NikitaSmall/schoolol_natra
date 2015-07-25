module Sinatra
  module SchoolApp
    module Routing
      module Orders

        def self.registered(app)
          show_cart = lambda do
            @products = Order.get_cart(session[:cart])
            slim :'orders/cart', locals: { products: @products }
          end

          checkout_form = lambda do
            @order = Order.new
            slim :'orders/checkout', locals: { order: @order }
          end

          register_order = lambda do
            redirect '/' if session[:cart].nil? # or session[:cart].length <= 0

            @order = Order.new params[:order]
            products = Order.get_cart(session[:cart])

            if @order.save
              @order.create_purchases(products)
              session[:cart] = nil # destroy cart

              redirect '/'
            else
              slim :'orders/checkout', locals: { order: @order, errors: @order.errors }
            end

          end

          app.get '/cart', &show_cart
          app.get '/checkout', &checkout_form
          app.post '/checkout', &register_order
        end

      end
    end
  end
end