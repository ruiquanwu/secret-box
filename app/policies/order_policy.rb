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
    #@user == @record.album.user && @record.status.downcase == "submitted"
  end
  
  def confirm?
    create?
  end
  
  def stripe_payment_confirm?
    update?
  end

  def paypal_payment_confirm?
    update?
  end
  
  def cancel?
    @user == @record.album.user && (@record.status.downcase == "submitted" || @record.status.downcase == "request cancelation")
  end
end