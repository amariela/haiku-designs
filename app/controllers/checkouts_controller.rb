class CheckoutsController < ApplicationController
  def show
    @cart = session[:cart]
    @cart_items = Product.find(@cart.keys)

    # If the user is logged in, use their shipment; if not, use the guest shipment from session
    if current_user
      @shipment = current_user.shipment
    else
      # Retrieve the guest shipment from the session using the ID stored in the session
      @shipment = Shipment.find_by(id: session[:guest_shipment]) || Shipment.new
    end

    # Calculate subtotal
    @subtotal = 0
    @cart_items.each do |product|
      quantity = @cart[product.id.to_s]
      @subtotal += product.price * quantity
    end

    # Get tax rates (default to 0 if no shipment is available)
    @gst_rate = @shipment&.province&.gst_rate || 0.0
    @pst_rate = @shipment&.province&.pst_rate || 0.0
    @hst_rate = @shipment&.province&.hst_rate || 0.0

    # Calculate totals
    @gst_total = @subtotal * @gst_rate
    @pst_total = @subtotal * @pst_rate
    @hst_total = @subtotal * @hst_rate
    @tax_amount = @gst_total + @pst_total + @hst_total
    @shipping_cost = 10.00
    @grand_total = @subtotal + @tax_amount + @shipping_cost
  end

  def create
    # If the user is logged in, use the current_user; otherwise, create a guest user
    user = current_user || create_guest_user

    # Check if the user has a valid shipment
    shipment = user.shipment || create_shipment_for_guest(user)

    # Recalculate subtotal and tax totals here
    @cart = session[:cart]
    @cart_items = Product.find(@cart.keys)

    # Calculate subtotal
    @subtotal = 0
    @cart_items.each do |product|
      quantity = @cart[product.id.to_s]
      @subtotal += product.price * quantity
    end

    # Get tax rates (default to 0 if no shipment is available)
    @gst_rate = shipment&.province&.gst_rate || 0.0
    @pst_rate = shipment&.province&.pst_rate || 0.0
    @hst_rate = shipment&.province&.hst_rate || 0.0

    # Calculate tax totals
    @gst_total = @subtotal * @gst_rate
    @pst_total = @subtotal * @pst_rate
    @hst_total = @subtotal * @hst_rate
    @tax_amount = @gst_total + @pst_total + @hst_total

    @shipping_cost = 10.00
    @grand_total = @subtotal + @tax_amount + @shipping_cost

    puts "Shipment: #{shipment.inspect}"
    puts "Province: #{shipment&.province.inspect}"
    puts "Subtotal: #{@subtotal}"
    puts "GST Total: #{@gst_total}, PST Total: #{@pst_total}, HST Total: #{@hst_total}"

    ActiveRecord::Base.transaction do
      # Create the Order
      @order = user.orders.create!(
        total_price: calculate_cart_total,
        gst_total: @gst_total,
        pst_total: @pst_total,
        hst_total: @hst_total,
        status: "pending"
      )

      # Create OrderItems
      @cart.each do |product_id, quantity|
        product = Product.find(product_id)
        @order.order_items.create!(
          product_id: product.id,
          quantity: quantity,
          price: product.price
        )
      end
    end

    # If everything is good
    reset_session_cart
    redirect_to success_checkout_path

  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = "Checkout failed: #{e.message}"
    redirect_to error_checkout_path
  end

  def success
  end
  def error
  end

  private

  def create_guest_user
    # Create a guest user if not logged in
    guest_user = User.create!(email: "guest_#{Time.now.to_i}@example.com", password: SecureRandom.hex(8))
    session[:guest_user_id] = guest_user.id
    guest_user
  end

  def create_shipment_for_guest(user)
    default_province_id = 1 # ALBERTA is default for now
    # Create a default shipment for the guest if one does not exist
    Shipment.create!(user: user, province_id: default_province_id)
  end

  def calculate_cart_total
    @cart = session[:cart]
    @cart.sum do |product_id, quantity|
      product = Product.find(product_id)
      product.price * quantity
    end + 10.00 # shipping cost
  end

  def reset_session_cart
    session[:cart] = {}
    session[:guest_shipment] = nil
  end
end
