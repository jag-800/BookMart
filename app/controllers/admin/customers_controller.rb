class Admin::CustomersController < ApplicationController
  
  def index
    @customers = Customer.page
  end

  def show
  end

  def edit
  end
end
