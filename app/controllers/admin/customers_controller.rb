class Admin::CustomersController < ApplicationController
  
  def index
    @customers = Customer.page
  end

  def show
    @customer = Customer.find(params[:id])
    @items = @customer.items
    @tags = @items.flat_map(&:tag_list).uniq
    @tag_counts = @items.each_with_object(Hash.new(0)) do |item, counts|
      item.tag_list.each { |tag| counts[tag] += 1 }
    end
  end

  def edit
  end
end
