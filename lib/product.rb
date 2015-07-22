class Product
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text

  validates_presence_of :title, message: 'Название необходимо заполнить!'
  validates_uniqueness_of :title, message: 'Название должно быть уникальным! Выберите другое название.'
end