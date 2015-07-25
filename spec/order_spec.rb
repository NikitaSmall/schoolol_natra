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
    Product.create id: 1, title: 'Best Sell Ever!!!', price: 10
    products = Order.get_cart({ 1 => 2 })

    expect(products.first.title).to eq('Best Sell Ever!!!')
    expect(products.first.count).to eq(2)
  end
end