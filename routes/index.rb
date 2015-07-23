module Sinatra
  module SchoolApp
    module Routing
      module Index

        def self.registered(app)
          main_page = lambda do
            @products = Product.all
            slim :index, locals: { name: 'nikita', products: @products }
          end

          app.get "/", &main_page
        end

      end
    end
  end
end