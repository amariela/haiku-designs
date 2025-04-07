class ShipmentsController < ApplicationController
  before_action :authenticate_user!, except: [  :new, :create ]
  before_action :set_shipment, only: [ :show, :edit, :update ]

  def new
    # If logged in, create shipment for the user; else create a guest shipment in session
    if current_user
      @shipment = current_user.build_shipment
    else
      @shipment = Shipment.new  # Create a temporary shipment for guests
    end
  end

  def create
    if current_user
      # For logged-in users, create and save shipment to the database
      @shipment = current_user.build_shipment(shipment_params)
      if @shipment.save
        flash[:notice] = "Shipping details created successfully."
        redirect_to shipment_path(@shipment)  # Redirect to user shipment page
      else
        render :new, status: :unprocessable_entity
      end
    else
      # For guest users, store shipment data in the session instead of the database
      @shipment = Shipment.new(shipment_params)
      if @shipment.save
        session[:guest_shipment] = @shipment.id  # Store the guest shipment ID in session
        flash[:notice] = "Shipping details saved temporarily."
        redirect_to checkout_path  # Proceed to checkout
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show
    redirect_to new_shipment_path if @shipment.nil?
  end

  def edit
    redirect_to new_shipment_path if @shipment.nil?
  end

  def update
    if @shipment.nil?
      redirect_to new_shipment_path and return
    end
    if @shipment.update(shipment_params)
      flash[:notice] = "Shipping details updated successfully."
      redirect_to shipment_path(@shipment)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_shipment
    if current_user
      @shipment = current_user.shipment
    else
      @shipment = Shipment.find_by(id: session[:guest_shipment]) || Shipment.new  # Retrieve guest shipment from session
    end
  end

  def shipment_params
    params.require(:shipment).permit(:first_name, :last_name, :phone_number, :address, :city, :province_id, :postal_code)
  end
end
