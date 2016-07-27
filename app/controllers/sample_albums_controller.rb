class SampleAlbumsController < ApplicationController
  
  def new
    @sample_album = SampleAlbum.new
    authorize @sample_album
  end
  
  def create
    @sample_album = SampleAlbum.new(sample_album_params)
    authorize @sample_album
    
    if @sample_album.save
      flash[:notice] = "Sample Album was saved."
      redirect_to sample_albums_path
    else
      flash.now[:error] = "There is error on saving sample album"
      render :new
    end
  end
  
  def edit
    @sample_album = SampleAlbum.find(params[:id])
    authorize @sample_album
  end
  
  def update
    @sample_album = SampleAlbum.find(params[:id])
    authorize @sample_album

    if @sample_album.update_attributes(sample_album_params)
      flash[:notice] = "Sample Album was saved."
      redirect_to sample_albums_path
    else
      flash.now[:error] = "There is error on saving sample album"
      render :edit
    end
  end

  def index
    @sample_albums = SampleAlbum.all.paginate(page: params[:page], per_page: 3)
    authorize @sample_albums
  end
  
  def destroy
    @sample_album = SampleAlbum.find(params[:id])
    authorize @sample_album
    @sample_album.destroy
    
    redirect_to sample_albums_path
  end
  
  private
  
  def sample_album_params
    params.require(:sample_album).permit(:name, :max_page, :photo_per_page, :color, :photo_size,
      :orientation, :avatar, :album_layout, :description, :price, :number_in_stock, :has_memo, :features)
  end
end
