class Order
  include DataMapper::Resource

  property :id, Serial

  property :name, String
  property :phone, String
  property :total_price, Float

  property :note, Text
  property :paid, Boolean, default: false

  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :purchases

  validates_presence_of :name, message: 'Вы должны назвать себя.'
  validates_presence_of :phone, message: 'Вы должны оставить свой номер телефона.'

  def self.get_cart(cart)
    return nil if cart.nil?

    products = Product.all(id: cart.keys)
    cart.each do |id, count|
      products.all(id: id).first.count = count
    end

    products
  end
end