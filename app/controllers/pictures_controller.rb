class PicturesController < ApplicationController
  def new
    @picture = Picture.new
  end
  
  def create
    # create multiple picture for files
    params[:picture][:context].each do |picture|
      @picture = Picture.new(:context => picture)
      @picture.user = current_user
        
      if @picture.save

      else
        render :new
      end
    end
    respond_to do |format|
      format.js {redirect_to  pictures_path(format: :js)}
    end
  end
  
  def index
    @pictures = Picture.all.order("created_at DESC").paginate(page: params[:page], per_page: 6)
  end
  
  def mass_delete
    Picture.where(:id => params[:picture][:ids]).delete_all
    respond_to do |format|
      format.html {redirect_to pictures_path}
      format.js {redirect_to pictures_path(format: :js)}
    end
  end
  
  private
  
  def picture_params
    params.require(:picture).permit(:context)
  end
end
