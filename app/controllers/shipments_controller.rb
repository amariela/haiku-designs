class ShipmentsController < ApplicationController
  before_action :authenticate_user!  # Only logged in user can access
  before_action :set_shipment, only: [ :show, :edit, :update ]

  def new
    @shipment = current_user.build_shipment
  end

  def create
    @shipment = current_user.build_shipment(shipment_params)
    if @shipment.save
      flash[:notice] = "Shipping details created successfully."
      redirect_to shipment_path
    else
      render :new, status: :unprocessable_entity
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
      redirect_to shipment_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_shipment
    @shipment = current_user.shipment
  end


  def shipment_params
    params.require(:shipment).permit(:first_name, :last_name, :phone_number, :address, :city, :province_id, :postal_code)
  end
end
