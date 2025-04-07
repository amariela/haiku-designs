class ChangeUserIdNullInShipments < ActiveRecord::Migration[7.2]
  def change
    change_column_null :shipments, :user_id, true
  end
end
