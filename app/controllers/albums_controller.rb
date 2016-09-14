class AlbumsController < ApplicationController
  respond_to :html, :json
  
  def index
    if current_user
      @albums = current_user.albums.page(params[:page]).per(3).order(updated_at: :desc)
      #.paginate(page: params[:page], per_page: 3)
      #authorize @albums
    else
      flash[:error] = "You must be logged in"
      redirect_to new_user_session_path
    end

  end
  
  def show
    @album = Album.friendly.find(params[:id])
    authorize @album
  end

  def edit
    @album = Album.friendly.find(params[:id])
    @sample_albums = SampleAlbumSearch.search(sample_album_search_params).results
    
    gon.sample_albums = @sample_albums
    gon.format_features_array = SampleAlbum.format_features_array
    @default_sample_album = @sample_albums.first
    authorize @album
  end
  
  def update
    @album = Album.friendly.find(params[:id])
    @album.update_attributes(album_params)
    @album.sample_album = SampleAlbum.find(@album.style)
    
    if @album.save
      flash[:notice] = "Album was updated."
      redirect_to @album
    else
      flash[:error] = "Error updating Album."
      render :edit
    end
      
  end

  def new
    @album = Album.new
    @sample_albums = SampleAlbumSearch.search(sample_album_search_params).results
    gon.sample_albums = @sample_albums
    gon.format_features_array = SampleAlbum.format_features_array
    @default_sample_album = @sample_albums.first
    authorize @album
  end

  def create
    @album = Album.new(album_params)
    @album.user = current_user
    @sample_album = SampleAlbum.find(@album.style)
    @album.sample_album = @sample_album
    
    # variables to use when render new
    @sample_albums = SampleAlbumSearch.search(sample_album_search_params).results
    gon.sample_albums = @sample_albums
    gon.format_features_array = SampleAlbum.format_features_array
    @default_sample_album = @sample_albums.first
#    @album.setAttributes(@sample_album)
    authorize @album
    
    if @album.save
      flash[:notice] = "Album was saved."
      redirect_to @album
    else
      flash.now[:error] = "There is error on saving album"
      render :new
    end
  end
  
  # use for displying album content with both page
  def view_only
    @album = Album.friendly.find(params[:id])
    photo_per_page = @album.sample_album.photo_per_page
    authorize @album
    @photos = @album.photos.page(params[:page]).per(photo_per_page*2)
    @photos_left_page = @photos.first(photo_per_page)
    @photos_right_page = @photos.last(photo_per_page)
  end
  
  def destroy
    @album = Album.friendly.find(params[:id])
    authorize @album
    if @album.orders.count > 0
      flash[:error] = "Cannot delete this album because There is at least one order associate with it."
    else
      flash[:notice] = "Album #{@album.name} has deleted"
      @album.destroy
    end

    respond_to do |format|
      format.html { redirect_to albums_path}
    end
  end
  
  def front_cover
    @album = Album.friendly.find(params[:id])
    @pictures = current_user.pictures.order("created_at DESC")
  end
  
  def update_front_cover
    @album = Album.friendly.find(params[:id])
    authorize @album
    @album.front_cover = params[:front_cover]
    @album.save
    render :nothing => true
  end

  private

  def album_params
    params.require(:album).permit(:name, :style, :description)
  end

  def album_manager_params
    params.require(:album).permit(:name, :style, :max_page, :photo_per_page, :color,
      :orientation, :avatar, :album_layout, :description, :price, :number_in_stock, :has_memo)
  end
  
  def sample_album_search_params
    params.permit(:max_page, :orientation, :photo_per_page, :has_memo, :number_in_stock, :price)
  end
end
