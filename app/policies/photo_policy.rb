class PhotoPolicy < ApplicationPolicy
  def index?
    @user == @record.album.user
  end
  
  def update_photos?
    index?
  end
  
  def insert?
    index?
  end
  
  def append?
    index?
  end
  
  def new?
    create?
  end
  
  def create?
    @user == @record.album.user
  end
end