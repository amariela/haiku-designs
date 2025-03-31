class CreateShipments < ActiveRecord::Migration[7.2]
  def change
    create_table :shipments do |t|
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.string :address, limit: 255
      t.string :postal_code, limit: 6
      t.string :phone_number, limit: 11
      t.string :city, limit: 50
      t.string :country, limit: 6, default: "Canada"
      t.timestamps
    end
  end
end
