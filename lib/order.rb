class Order
  include DataMapper::Resource

  property :id, Serial

  property :name, String
  property :phone, String
  property :total_price, Float

  property :note, Text

  property :created_at, DateTime
  property :updated_at, DateTime

  validates_presence_of :name, message: 'Вы должны назвать себя.'
  validates_presence_of :phone, message: 'Вы должны оставить свой номер телефона.'
end