class OrderManagementController < ApplicationController
  def index
    @orders =  Order.where(user_id: current_user.id).all.paginate(page: params[:page], per_page: 5)
  end

  def show
  end
  
  def admin_index
    @orders = Order.all.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    @order = Order.find(params[:id])
  end
  
end
