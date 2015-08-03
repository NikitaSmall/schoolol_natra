require "#{File.dirname(__FILE__)}/spec_helper"

describe 'product' do
  before(:each) do
    Category.create(title: 'category', id: 1, base_price: 15)
    @product = Product.new(title: 'product', category_id: 1)
    @product.save
  end

  it 'is valid' do
    expect(@product).to be_valid
  end

  it 'is not valid' do
    not_valid_product = Product.new
    expect(not_valid_product).to_not be_valid
  end

  it 'is not uniqueness' do
    not_valid_product = Product.new(title: 'product')
    expect(not_valid_product).to_not be_valid
  end

  it 'has extremely low price' do
    not_valid_product = Product.new(title: 'product', price: -5)
    expect(not_valid_product).to_not be_valid
  end
end