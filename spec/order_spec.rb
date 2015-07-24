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
end