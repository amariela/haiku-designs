class Shipment < ApplicationRecord
  validates :province_id, :country, presence: true

  belongs_to :user, optional: true
  belongs_to :province
  before_validation :normalize_postal_code, :set_default_country
  before_validation :set_province_id

  def self.ransackable_attributes(auth_object = nil)
    [ "address", "city", "country", "created_at", "first_name", "id", "id_value", "last_name", "phone_number", "postal_code", "province_id", "updated_at", "user_id" ]
  end

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
