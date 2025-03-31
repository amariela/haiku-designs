class RemoveExtraColumnsFromDeviseUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :address, :string
    remove_column :users, :postal_code, :string
    remove_column :users, :phone_number, :string
    remove_column :users, :city, :string
    remove_column :users, :country, :string
  end
end
