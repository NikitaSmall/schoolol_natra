require "#{File.dirname(__FILE__)}/spec_helper"

describe 'Order' do
  before(:each) do
    @order = Order.create name: 'nikitasmall', phone: '+381234567890'
  end

  it 'is valid' do
    expect(@order).to be_valid
  end

  it 'is not valid' do
    not_valid_order = Order.new

    expect(not_valid_order).to_not be_valid
  end

  # test for correct cart recover
  it 'should return actual cart' do
    Category.create(title: 'category', id: 1, base_price: 15)
    @product = Product.create(title: 'Best Sell Ever!!!', category_id: 1, id: 1)
    products = Order.get_cart({ @product.id => 2 })

    expect(products.first.title).to eq('Best Sell Ever!!!')
    expect(products.first.count).to eq(2)
  end

  # test for checkout
  it 'should checkout the user' do
    Category.create(title: 'category', id: 1, base_price: 15)
    @product = Product.create(title: 'product', category_id: 1, id: 1)
    products = Order.get_cart({ @product.id => 2 })

    @order.create_purchases(products)

    expect(@order.total_price).to eq 30
    expect(Purchase.first.order).to eq @order
  end
end