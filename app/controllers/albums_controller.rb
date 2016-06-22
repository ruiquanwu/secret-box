class AlbumsController < ApplicationController
  def test
    @sample_albums  = SampleAlbum.all
    respond_with @sample_albums
  end
  
  def index
    #@albums = current_user.albums
    @albums = current_user.albums.paginate(page: params[:page], per_page: 6)
  end

  def front_cover
    @album = Album.find(params[:id])
  end

  def show
    @album = Album.find(params[:id])
  end

  def edit
  end

  def new
    @album = Album.new
    @sample_albums  = SampleAlbum.all
    @default_sample_album = @sample_albums.first
  end

  def create
    @album = Album.new(album_params)
    @album.user = current_user
    @sample_album = SampleAlbum.find(@album.style)
    @album.setAttributes(@sample_album)
    if @album.save
      flash[:notice] = "Album was saved."
      redirect_to @album
    else
      flash.now[:error] = "There is error on saving album"
      render :new
    end

  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_path}
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :style)
  end

  def album_manager_params
    params.require(:album).permit(:name, :style, :max_page, :photo_per_page, :color,
      :orientation, :avatar, :album_layout, :description, :price, :number_in_stock, :has_memo)
  end
end
