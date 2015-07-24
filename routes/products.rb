module Sinatra
  module SchoolApp
    module Routing
      module Products

        def self.registered(app)
          create_form = lambda do
            @product = Product.new
            slim :'products/create', locals: { product: @product }
          end

          create_product = lambda do
            @product = Product.new(params[:product])

            if @product.save
              redirect '/'
            else
              slim :'products/create', locals: { product: @product, errors: @product.errors }
            end
          end

          add_product_to_cart = lambda do
            session[:cart] ||= Hash.new(0) # try to initialize new cart
            session[:cart][params[:id]] += 1 # count of line_items


            redirect '/'
          end

          decrease_product_count_at_cart = lambda do
            redirect '/cart' if session[:cart].nil?

            session[:cart][params[:id]] -= 1
            session[:cart].delete_if { |id, count| count <= 0 }

            redirect '/cart'
          end

          app.get "/products/create", &create_form
          app.post "/products", &create_product

          app.post "/products/add/:id", &add_product_to_cart
          app.post "/products/remove/:id", &decrease_product_count_at_cart
        end

      end
    end
  end
end