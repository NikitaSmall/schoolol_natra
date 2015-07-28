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
              redirect_with_notice '/', 'Только что Вы создали замечательный товар!'
            else
              slim :'products/create', locals: { product: @product, errors: @product.errors }
            end
          end

          app.get "/products/create", &create_form
          app.post "/products", &create_product
        end

      end
    end
  end
end