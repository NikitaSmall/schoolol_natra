module Sinatra
  module SchoolApp
    module Routing
      module Orders

        def self.registered(app)
          checkout_form = lambda do
            if session[:cart].nil? # or session[:cart].length <= 0
              flash[:notice] = 'Ваша корзина пуста!'
              redirect '/'
            end

            @order = Order.new
            slim :'orders/checkout', locals: { order: @order }
          end

          register_order = lambda do
            if session[:cart].nil? # or session[:cart].length <= 0
              flash[:notice] = 'Ваша корзина пуста!'
              redirect '/'
            end

            @order = Order.new params[:order]
            products = Order.get_cart(session[:cart])

            if @order.save
              @order.create_purchases(products)
              session[:cart] = nil # destroy cart

              flash[:notice] = 'Заказ успешно оформлен!'
              redirect '/'
            else
              slim :'orders/checkout', locals: { order: @order, errors: @order.errors }
            end

          end

          orders = lambda do
            @orders = Order.all
            slim :'orders/orders', locals: { orders: @orders }
          end

          show_order = lambda do
            @order = Order.get(params[:id])
            slim :'orders/show', locals: { order: @order }
          end

          app.get '/checkout', &checkout_form
          app.post '/checkout', &register_order

          app.get '/orders', &orders
          app.get '/orders/:id', &show_order
        end

      end
    end
  end
end