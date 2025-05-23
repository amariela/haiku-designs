class Province < ApplicationRecord
  validates :name, :pst_rate, :gst_rate, :hst_rate, presence: true
  validates :name, length: { is: 2 }, format: { with: /\A[A-Z]{2}\z/, message: "Must be two uppercase letters" }

  validates :pst_rate, :gst_rate, :hst_rate, numericality: { allow_nil: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1, message: "Must be a decimal between 0 and 1" }

  has_many :shipments

  def self.ransackable_associations(auth_object = nil)
    [ "shipments" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "gst_rate", "hst_rate", "id", "id_value", "name", "pst_rate", "updated_at" ]
  end
end
