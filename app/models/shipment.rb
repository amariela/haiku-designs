class Shipment < ApplicationRecord
  validates :first_name, :last_name, :address, :phone_number, :postal_code, :city, :province_id, :country, presence: true
  validates :postal_code, format: {
    with: /\A[A-Z]\d[A-Z]\d[A-Z]\d\z/, message: "Must follow the format A1A1A1"
  }

  belongs_to :user
  belongs_to :province
  before_validation :normalize_postal_code, :set_default_country
  before_validation :set_province_id

  private

  def normalize_postal_code
    self.postal_code = postal_code.upcase.strip if postal_code.present?
  end

  def set_default_country
    self.country = "Canada"
  end

  def set_province_id
    return if province_id.present? || province.blank?  # Avoid overwriting if it's already set

    matched_province = Province.find_by(name: province)
    self.province_id = matched_province.id if matched_province
  end
end
