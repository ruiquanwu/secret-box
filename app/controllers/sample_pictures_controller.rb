class SamplePicturesController < ApplicationController
  def index
    @sample_pictures = SamplePicture.page(params[:page]).per(10)
    #.all.paginate(page: params[:page], per_page: 10)
    authorize @sample_pictures
  end

  def new
    @sample_picture = SamplePicture.new
    authorize @sample_picture
  end
  
  def create
    @sample_picture = SamplePicture.new(sample_picture_params)
    authorize @sample_picture
    
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
    authorize @sample_picture
  end
  
  def update
    @sample_picture = SamplePicture.find(params[:id])
    authorize @sample_picture
    
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
    authorize @sample_picture
    @sample_picture.destroy
    
    redirect_to sample_pictures_path
  end
  
  private
  
  def sample_picture_params
    params.require(:sample_picture).permit(:size, :price)
  end
end
