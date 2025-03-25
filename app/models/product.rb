class Product < ApplicationRecord
  validates :name, :price, :stock_quantity, presence: true
  belongs_to :category
end
