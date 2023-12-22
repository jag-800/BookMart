class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_address, only: [:edit, :update, :destroy]
  
  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
  end
  
  def create
  end
  
  def update
  end

  def destroy
  end
  
  private
  
  def address_params
    params.arequire(:address).permit(:post_code, :address, :name)
  end
  
  def ensure_address
    @addresses = current_cusotmer.addresses
    @address = @addresses.find_by(id: params[:id])
    redirect_to addresses_path unless @address
  end
end
