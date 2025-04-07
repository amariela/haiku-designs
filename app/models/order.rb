class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :gst_total, :pst_total, :hst_total, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_associations(auth_object = nil)
    [ "order_items", "products", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "gst_total", "hst_total", "id", "id_value", "pst_total", "status", "total_price", "updated_at", "user_id" ]
  end
end
