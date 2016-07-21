class OrderPolicy < ApplicationPolicy
  def new?
    create?
  end
  
  def create?
    @user == @record.album.user
  end
  
  def edit?
    update?
  end
  
  def update?
    @user == @record.album.user && @record.status.downcase == "pending"
  end
  
  def destroy?
    update?
  end  
  
  def checkout?
    update?
  end
  
  def confirm?
    update?
  end
end