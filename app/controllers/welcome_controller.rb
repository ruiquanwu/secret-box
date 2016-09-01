class WelcomeController < ApplicationController  
  def index
    @albums = current_user.albums.order(updated_at: :desc)
    @recent_album = @albums.first
    @pictures = current_user.pictures
    @pictures_in_album = current_user.pictures.where("photo_id is not null")
    @orders = current_user.orders.order(updated_at: :desc)
    @recent_order = @orders.first
    
  end

  def about
  end
end
