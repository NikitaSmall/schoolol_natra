module Sinatra
  module SchoolApp
    module Routing
      module Orders

        def self.registered(app)
          checkout_form = lambda do
            redirect_with_notice '/', 'Ваша корзина пуста!' if session[:cart].nil?

            @order = Order.new
            slim :'orders/checkout', locals: { order: @order }
          end

          register_order = lambda do
            redirect_with_notice '/', 'Ваша корзина пуста!' if session[:cart].nil?

            @order = Order.new params[:order]
            products = Order.get_cart(session[:cart])

            if @order.save
              @order.create_purchases(products)
              session[:cart] = nil # destroy cart

              redirect_with_notice '/', 'Заказ успешно оформлен!'
            else
              slim :'orders/checkout', locals: { order: @order, errors: @order.errors }
            end

          end

          # routes that protected from anon

          orders = lambda do
            protected! # helper that require admin to login

            @orders = Order.all
            slim :'orders/orders', locals: { orders: @orders }
          end

          show_order = lambda do
            protected! # helper that require admin to login

            @order = Order.get(params[:id]) || halt(404)
            slim :'orders/show', locals: { order: @order }
          end

          app.get '/checkout', &checkout_form
          app.post '/checkout', &register_order

          # routes that protected from anon

          app.get '/orders', &orders
          app.get '/orders/:id', &show_order
        end

      end
    end
  end
end