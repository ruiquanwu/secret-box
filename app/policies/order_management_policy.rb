class OrderManagementPolicy < Struct.new(:user, :order_management)
  def index?
    user.present?
  end
  def admin_index?
    user.admin?
  end
  
  def edit?
    admin_index?
  end
  
  def update?
    admin_index?
  end
  
  def download
    admin_index?
  end
end