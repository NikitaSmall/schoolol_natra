class Product
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :featured, Boolean, default: false

  property :created_at, DateTime
  property :updated_at, DateTime

  validates_presence_of :title, message: 'Название необходимо заполнить!'
  validates_uniqueness_of :title, message: 'Название должно быть уникальным! Выберите другое название.'
end