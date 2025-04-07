class UpdateOrdersForValidations < ActiveRecord::Migration[7.0]
  def change
    change_column_null :orders, :status, false
    change_column_null :orders, :total_price, false

    change_column_default :orders, :gst_total, from: nil, to: 0.0
    change_column_default :orders, :pst_total, from: nil, to: 0.0
    change_column_default :orders, :hst_total, from: nil, to: 0.0

    change_column_null :orders, :gst_total, false
    change_column_null :orders, :pst_total, false
    change_column_null :orders, :hst_total, false
  end
end
