module Sinatra
  module SchoolApp
    module Routing
      module Categories

        def self.registered(app)
          index = lambda do
            protected!

            @caregories = Category.all
            slim :'categories/index', locals: { categories: @categories }
          end

          app.get '/categories', &index
        end

      end
    end
  end
end