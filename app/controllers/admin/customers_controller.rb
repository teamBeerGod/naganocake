class Admin::CustomersController < ApplicationController
  def index
   @user = Customer.all
  end

  def show
    @user = Customer.find(params[:id])
    
  end

  def edit
  end

  def update
  end

end
