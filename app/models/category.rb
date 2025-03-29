class Category < ApplicationRecord
  validates :name, presence: true
  has_many :products, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "id_value", "name", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "products" ]
  end
end
