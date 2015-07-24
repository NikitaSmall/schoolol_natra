class Purchase
  include DataMapper::Resource

  property :id, Serial
  property :price, Float
  property :quantity, Integer

  belongs_to :order
  belongs_to :product
end