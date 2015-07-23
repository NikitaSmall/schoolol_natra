module Sinatra
  module SchoolApp
    module Routing
      module Index

        def self.registered(app)
          app.get "/" do
            @products = Product.all
            slim :index, locals: { name: 'nikita', products: @products }
          end
        end

      end
    end
  end
end