module Sinatra
  module SchoolApp
    module Routing
      module Orders

        def self.registered(app)
          show_cart = lambda do
            @products = Order.get_cart(session[:cart])
            slim :'orders/cart', locals: { products: @products }
          end

          app.get '/cart', &show_cart
        end

      end
    end
  end
end