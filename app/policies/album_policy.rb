class AlbumPolicy < ApplicationPolicy
  def index?
    @user == @record.user || @user.admin?
  end
  
  def show?
    @user.present? && @record.user == user || @user.admin?
  end

  def view_only?
    index?
  end  
  
  def update_front_cover?
    show?
  end
end