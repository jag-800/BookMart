# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_customer, only: [:create]

  # def guest_sign_in
  #   customer = Customer.guest
  #   sign_in customer
  #   flash[:error] = 'ゲストユーザーとしてログインしました。'
  #   redirect_to root_path
  # end
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def reject_inactive_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer && @customer.valid_password?(params[:customer][:password]) && !@customer.is_active
      flash[:danger] = 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
      redirect_to new_customer_session_path
    end
  end
end
