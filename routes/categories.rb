module Sinatra
  module SchoolApp
    module Routing
      module Categories

        def self.registered(app)

          index = lambda do
            protected!

            @categories = Category.all
            slim :'categories/index', locals: { categories: @categories }
          end

          create_form = lambda do
            @category = Category.new
            slim :'categories/create', locals: { category: @category }
          end

          create_category = lambda do
            @category = Category.new(params[:category])

            if @category.save
              redirect_with_notice '/categories',
                'Только что Вы создали замечательную категорию!'
            else
              slim :'categories/create',
                locals: { category: @category, errors: @category.errors }
            end
          end

          app.get '/categories', &index
          app.get '/categories/create', &create_form

          app.post '/categories', &create_category
        end

      end
    end
  end
end
