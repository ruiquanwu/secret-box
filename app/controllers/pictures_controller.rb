class PicturesController < ApplicationController
  def new
    @picture = Picture.new
  end
  
  def create
    # create multiple picture for files
    params[:picture][:context].each do |picture|
      @picture = Picture.new(:context => picture)
      @picture.user = current_user
      @picture.save
    end
    respond_to do |format|
      #format.html{redirect_to  pictures_path(page: 1)}
      format.js {redirect_to  pictures_path(page: 1)}
    end
  end
  
  def index
    #@pictures = Picture.all.order("created_at DESC").paginate(page: params[:page], per_page: 6)
    @pictures = current_user.pictures.order("created_at DESC").page(params[:page]).per(6)
    
   # respond_to do |format|
  #    format.html
  #    format.js
 #   end
  end
  
  def mass_delete
    Picture.where(:id => params[:picture][:ids]).delete_all
    respond_to do |format|
      format.html {redirect_to pictures_path}
      format.js {redirect_to pictures_path(page: params[:page], format: :js)}
    end
  end
  
  def update_rotation
    @picture = Picture.find(params[:id])
    # set picture rotation attributes based on orientation
    case
    when params[:orientation] == "landscape"
      # flip the attribute for each request
      if @picture.rotate_landscape
        @picture.rotate_landscape = nil
      else
        @picture.rotate_landscape = true
      end
    when params[:orientation] == "portrait"
      if @picture.rotate_portrait
        @picture.rotate_portrait = nil
      else
        @picture.rotate_portrait = true
      end
    end
    
    @picture.save
    respond_to do |format|
      format.js {render "layouts/hide_loading_bar"}
    end
  end
  
  private
  
  def picture_params
    params.require(:picture).permit(:context)
  end
end
