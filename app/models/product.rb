class Product < ApplicationRecord
  validates :name, :price, :stock_quantity, :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "id_value", "name", "price", "description", "stock_quantity", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end
end
