class Category
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :base_price, Float

  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :products

  validates_presence_of :title, message: 'Название должно присутствовать'
  validates_uniqueness_of :title, message: 'Название должно быть уникальным'

  validates_presence_of :base_price, message: 'Базовая цена должна присутствовать'
  validates_numericality_of :base_price, min: 0, message: 'Базовая цена должна быть больше нуля'

end