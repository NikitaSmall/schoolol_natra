class Order
  include DataMapper::Resource

  property :id, Serial

  property :name, String
  property :phone, String
  property :total_price, Float, default: 0

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

  def create_purchases(products)
    # iterate through the products to create purchases for current order
    products.each do |product|
      Purchase.create(price: product.price, count: product.count, order_id: self.id, product_id: product.id)
      self.total_price += product.price * product.count # summ total price for current order
    end
    save
  end
end