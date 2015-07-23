module Sinatra
  module SchoolApp
    module Routing
      module Products

        def self.registered(app)
          create_form = lambda do
            @product = Product.new
            slim :"products/create", locals: { product: @product }
          end

          create_product = lambda do
            @product = Product.new(params[:product])

            if @product.save
              redirect '/'
            else
              slim :"products/create", locals: { product: @product, errors: @product.errors }
            end
          end

          add_product_to_cart = lambda do
            products = session[:cart] unless session[:cart].nil?
            products ||= Hash.new(0) # try to initialize new cart
            products[params[:id]] += 1 # count of line_items

            session[:cart] = products

            redirect '/'
          end

          app.get "/products/create", &create_form
          app.post "/products", &create_product

          app.post "/products/add/:id", &add_product_to_cart
        end

      end
    end
  end
end