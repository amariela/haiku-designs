class CheckoutsController < ApplicationController
  def show
    @cart = session[:cart]
    @cart_items = Product.find(@cart.keys)
    @shipment = current_user.shipment

    # Calculate subtotal
    @subtotal = 0
    @cart_items.each do |product|
      quantity = @cart[product.id.to_s]
      @subtotal += product.price * quantity
    end

    # Get tax rates
    gst_rate = @shipment&.province&.gst_rate || 0
    pst_rate = @shipment&.province&.pst_rate || 0
    hst_rate = @shipment&.province&.hst_rate || 0

    # Tax rates for view
    @gst_rate = gst_rate
    @pst_rate = pst_rate
    @hst_rate = hst_rate

    # Calculate totals
    total_tax_rate = gst_rate + pst_rate + hst_rate
    @tax_amount = @subtotal * total_tax_rate
    @shipping_cost = 10.00
    @grand_total = @subtotal + @tax_amount + @shipping_cost
  end
end
