class Product
  include DataMapper::Resource
  attr_accessor :count

  property :id, Serial
  property :title, String
  property :description, Text
  property :featured, Boolean, default: false

  property :price, Float

  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :purchases

  validates_presence_of :title, message: 'Название необходимо заполнить!'
  validates_uniqueness_of :title, message: 'Название должно быть уникальным! Выберите другое название.'

  validates_presence_of :price, message: 'Цена должна быть указана!'
  validates_numericality_of :price, min: 0, message: 'Цена должна быть больше нуля!'
end