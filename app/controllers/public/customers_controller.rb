class Public::CustomersController < ApplicationController
  
  def mypage
  end
  
  def show
  end

  def edit
  end
  
  def update
  end

  def confirm
  end
  
  def withdraw
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number)
  end
  
end
