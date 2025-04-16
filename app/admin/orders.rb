ActiveAdmin.register Order do
  permit_params :user_id, :status, :gst_total, :pst_total, :hst_total, :total_price

  includes :user, order_items: :product

  index do
    selectable_column
    id_column
    column :user
    column :status
    column "Products" do |order|
      order.order_items.map do |item|
        "#{item.product.name} (x#{item.quantity})"
      end.join("<br>").html_safe
    end
    column "Sub-total" do |order|
      subtotal = order.order_items.sum { |item| item.price * item.quantity }
      number_to_currency(subtotal)
    end
    column "Shipping" do
      number_to_currency(10.00)
    end
    column :gst_total do |order|
      number_to_currency(order.gst_total)
    end
    column :pst_total do |order|
      number_to_currency(order.pst_total)
    end
    column :hst_total do |order|
      number_to_currency(order.hst_total)
    end
    column :total_price do |order|
      number_to_currency(order.total_price)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :status

      row "Products" do |order|
        table_for order.order_items do
          column "Product" do |item|
            item.product.name
          end
          column "Quantity" do |item|
            item.quantity
          end
          column "Price" do |item|
            number_to_currency(item.price)
          end
          column "Total" do |item|
            number_to_currency(item.price * item.quantity)
          end
        end
      end

      row "Sub-total" do |order|
        subtotal = order.order_items.sum { |item| item.price * item.quantity }
        number_to_currency(subtotal)
      end

      row "Shipping" do
        number_to_currency(10.00)
      end

      row "GST Total" do |order|
        number_to_currency(order.gst_total)
      end

      row "PST Total" do |order|
        number_to_currency(order.pst_total)
      end

      row "HST Total" do |order|
        number_to_currency(order.hst_total)
      end

      row "Grand Total" do |order|
        grand_total = order.total_price
        number_to_currency(grand_total)
      end
    end
  end
end
