module Sinatra
  module SchoolApp
    module Routing
      module Carts

        def self.registered(app)
          add_product_to_cart = lambda do
            session[:cart] ||= Hash.new(0) # try to initialize new cart
            session[:cart][params[:id]] += 1 # count of line_items

            redirect '/'
          end

          decrease_product_count_at_cart = lambda do
            redirect '/cart' if session[:cart].nil?

            session[:cart][params[:id]] -= 1 # count of line_items
            session[:cart].delete_if { |id, count| count <= 0 } # destroy key-value if count of line items is zero

            session[:cart] = nil if session[:cart].length.zero?

            redirect '/cart'
          end

          show_cart = lambda do
            @products = Order.get_cart(session[:cart])
            slim :'carts/cart', locals: { products: @products }
          end

          empty_cart = lambda do
            session[:cart] = nil # make cart empty

            flash[:notice] = 'Ваша корзина очищена!'
            redirect '/'
          end

          app.get '/cart', &show_cart

          app.post '/cart/empty', &empty_cart

          app.post "/products/add/:id", &add_product_to_cart
          app.post "/products/remove/:id", &decrease_product_count_at_cart
        end

      end
    end
  end
end