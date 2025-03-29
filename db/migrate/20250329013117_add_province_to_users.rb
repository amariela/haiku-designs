class AddProvinceToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :province, null: false, foreign_key: true
  end
end
