class Province < ApplicationRecord
  validates :name, :pst_rate, :gst_rate, :hst_rate, presence: true
  validates :name, length: { is: 2 }, format: { with: /\A[A-Z]{2}\z/, message: "Must be two uppercase letters" }

  validates :pst_rate, :gst_rate, :hst_rate, numericality: { allow_nil: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1, message: "Must be a decimal between 0 and 1" }
end
