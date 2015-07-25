class Purchase
  include DataMapper::Resource

  property :id, Serial
  property :price, Float
  property :count, Integer

  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :order
  belongs_to :product
end