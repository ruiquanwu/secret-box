class SamplePicturesController < ApplicationController
  def index
    @sample_pictures = SamplePicture.all
  end

  def new
    @sample_picture = SamplePicture.new
  end
  
  def create
    @sample_picture = SamplePicture.new(sample_picture_params)
    
    if @sample_picture.save
      flash[:notice] = "Sample Picture was saved"
      redirect_to sample_pictures_path
    else
      flash.now[:error] = "Something wrong when creating sample picture"
      render :new
    end
  end

  def edit
    @sample_picture = SamplePicture.find(params[:id])
  end
  
  def update
    @sample_picture = SamplePicture.find(params[:id])
    
    if @sample_picture.update_attributes(sample_picture_params)
      flash[:notice] = "Sample Picture was updated"
      redirect_to sample_pictures_path
    else
      flash.now[:error] = "Something wrong when updating sample picture"
      render :edit
    end
  end
  
  def destroy
    @sample_picture = SamplePicture.find(params[:id])
    @sample_picture.destroy
    
    redirect_to sample_pictures_path
  end
  
  private
  
  def sample_picture_params
    params.require(:sample_picture).permit(:size, :price)
  end
end
