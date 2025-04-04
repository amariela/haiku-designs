class CartsController < ApplicationController
  before_action :initialize_cart

  def show
    @cart_items = Product.find(@cart.keys)
  end

  def add
    product_id = params[:product_id].to_s
    @cart[product_id] = (@cart[product_id] || 0) + 1
    session[:cart] = @cart # update session with the latest cart items
    redirect_to cart_path, notice: "Product added to cart."
  end

  def update
    # get product id param and update that product in the session with the correct quantity
    product_id = params[:product_id].to_s
    new_quantity = params[:quantity].to_i
    session_product_quantity = session[:cart][product_id]
    puts session_product_quantity
    puts new_quantity

    # if the new quantity is not the same as quantity stored in session, make the change
    if new_quantity != session_product_quantity
      session[:cart][product_id] = new_quantity
      redirect_to cart_path, notice: "Quantity updated."
    end
  end

  def remove
    product_id = params[:product_id].to_s

    session[:cart].delete(product_id)
    redirect_to cart_path, notice: "Item removed from cart."
  end

  private

  def initialize_cart
    session[:cart] ||= {} # initialize an empty cart if it doesn't exist yet
    @cart = session[:cart]
  end
end
