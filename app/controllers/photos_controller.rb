class PhotosController < ApplicationController

  def index
    @album = Album.friendly.find(params[:album_id])
    authorize @album
    @photos = @album.photos.paginate(page: params[:page], per_page: @album.sample_album.photo_per_page)
    @pictures = @album.pictures.where(:photo => nil).all#.limit(10)
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @album = Album.friendly.find(params[:album_id])
    @photo = Photo.find(params[:id])
  end

  def new
    @album = Album.friendly.find(params[:album_id])
    @photo = @album.photos.new
    @picture = Picture.new
    authorize @photo
  end

  def create
    @album = Album.friendly.find(params[:album_id])
    if @album.photos.where(:picture_id => nil).first
      @render_page = @album.photos.where(:picture_id => nil).first.photo_number
    else
      @render_page = @album.photos.count + 1
    end

    # Create new Picture for every uploaded file
#params[:photo][:picture].each do |picture|
      #@photo_in_panel = Photo.new(:picture => picture)
    #raise params
    @picture = Picture.new(:context => params[:picture][:context])
    @picture.album = @album
      # create new photo in album if there are more pictures
    if @picture.save
      if  @album.photos.count < @album.pictures.count
        @photo = Photo.new
        @photo.album = @album
        authorize @photo
        @photo.photo_number = @album.photos.count + 1
        @photo.save
      end
    else
      render :new
    end
    redirect_to album_photos_path+"?page="+ (@render_page.to_f/@album.photo_per_page).ceil.to_s

  end

  def crop
    @album = Album.friendly.find(params[:album_id])
    authorize @album
    @photo = Photo.find(params[:id])


    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_photos
    params[:updates_params].each do |(key,update_params)|
      @album = Album.find(update_params[:album_id])
      @photo = Photo.find(update_params[:photo_id])
      authorize @photo
      if update_params[:picture_id] == "0"
        if @photo.picture
          @photo.picture = nil
          @photo.memo = update_params[:memo]
        end
      else
        @photo.picture = Picture.find(update_params[:picture_id])
        @photo.memo = update_params[:memo]
      end
      @photo.save
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def insert
    @album = Album.friendly.find(params[:album_id])
    @current_photo = Photo.find(params[:id])
    authorize @current_photo
    @photo = @album.photos.new
    @photo_number = @current_photo.photo_number

    # update photo_number
    Photo.update_photo_number(@album, @photo_number)

    @photo.photo_number = @photo_number

    if @photo.save

      flash[:notice] = "Photo was inserted"
      #redirect_to album_photos_path+"?page="+(@album.photos.count.to_i/2).to_s
      redirect_to album_photos_path+"?page="+(@photo.photo_number.to_f/@album.photo_per_page).ceil.to_s
    else
      render action: 'insert'
      ##redirect_to [@album, @photo], notice: "Photo failed to save"
    end

  end

  def append
    @album = Album.friendly.find(params[:album_id])
    @current_photo = Photo.find(params[:id])
    authorize @current_photo
    @photo = @album.photos.new
    @photo_number = @current_photo.photo_number + 1

    # update photo_number
    Photo.update_photo_number(@album, @photo_number)

    @photo.photo_number = @photo_number

    if @photo.save

      flash[:notice] = "Photo was append"
      #redirect_to album_photos_path+"?page="+(@album.photos.count.to_i/2).to_s
      redirect_to album_photos_path+"?page="+(@photo.photo_number.to_f/@album.photo_per_page).ceil.to_s
    else
      render action: 'append'
      ##redirect_to [@album, @photo], notice: "Photo failed to save"
    end
  end

  def destroy
    @album = Album.friendly.find(params[:album_id])
    authorize @album
    @photo = Photo.find(params[:id])
    @photo_number = @photo.photo_number
    
    @album.photos.album_photos.each do |photo|
      if photo.photo_number > @photo_number
        photo.photo_number -= 1
        photo.save
      end
    end

    @photo.destroy

    redirect_to album_photos_path+"?page="+(@photo_number.to_f/@album.photo_per_page).ceil.to_s
  end

  private

  def photo_params
    params.require(:photo).permit(:memo, :picture, 
      :picture_crop_x, :picture_crop_y, :picture_crop_w, :picture_crop_h)
  end
 
end
