module Sinatra
  module SchoolApp
    module Routing
      module Products

        def self.registered(app)
          app.get "/products/create" do
            @product = Product.new
            slim :"products/create", locals: { product: @product }
          end

          app.post "/products" do
            @product = Product.new(params[:product])

            if @product.save
              redirect '/'
            else
              slim :"products/create", locals: { product: @product, errors: @product.errors }
            end
          end
        end

      end
    end
  end
end