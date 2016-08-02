class PicturesController < ApplicationController
  def new
    @album = Album.friendly.find(params[:album_id])
    @picture = Picture.new
  end
  
  def create
    @album = Album.friendly.find(params[:album_id])
    
    params[:picture][:context].each do |picture|
      @picture = Picture.new(:context => picture)
      @picture.album = @album
        
      if @picture.save
        flash[:notice] = "new picture was created"
      else
        flash[:error] = "new picture error"
        render :new
      end
    end
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def picture_params
    params.require(:picture).permit(:context)
  end
end
