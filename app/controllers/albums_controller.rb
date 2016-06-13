class AlbumsController < ApplicationController
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
    @album_samples  = Album.where(user_id: nil)
  end

  def create
    @album = Album.new(album_params)
    @album.user = current_user
    # @album.front_cover = "/assets/PhotoAlbums" + @album.style + ".jpg"
    @album.setAttributes
    if @album.save
      flash[:notice] = "Album was saved."
      redirect_to @album
    else
      flash.now[:notice] = "There is error on saving album"
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

  def album_manager_new
    @album = Album.new
  end

  def album_manager_create
    @album = Album.new(album_manager_params)

    if @album.save
      flash[:notice] = "Album was saved."
      redirect_to @album
    else
      flash.now[:notice] = "There is error on saving album"
      render :album_manager_new
    end
  end

  def album_manager_index
    #User.joins(:account).merge(Account.where(:active => true))
    @albums = Album.where(user_id: nil)
  end

  private

  def album_params
    params.require(:album).permit(:name, :style)
  end

  def album_manager_params
    params.require(:album).permit(:name, :style, :max_page, :photo_per_page,
      :orientation, :avatar, :album_layout, :description, :price, :number_in_stock, :has_memo)
  end
end
