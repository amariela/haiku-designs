class AddProvinceToShipment < ActiveRecord::Migration[7.2]
  def change
    add_reference :shipments, :province, null: false, foreign_key: true
  end
end
