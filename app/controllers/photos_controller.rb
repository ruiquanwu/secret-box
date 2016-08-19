class PhotosController < ApplicationController

  def index
    @album = Album.friendly.find(params[:album_id])
    authorize @album
    @photos = @album.photos.page(params[:page]).per(@album.sample_album.photo_per_page)
    #paginate(page: params[:page], per_page: @album.sample_album.photo_per_page)
    @pictures = current_user.pictures.where(:photo_id => nil).order("updated_at DESC")
    
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
    # append new page with photo_per_page for belonging album
    @album = Album.friendly.find(params[:album_id])
    photos_per_page = @album.sample_album.photo_per_page
    # check if photos reach album maximum photos
    if @album.photos.count + photos_per_page > @album.sample_album.max_page * @album.sample_album.photo_per_page
      flash.now[:error] = "Album Pages have reach maximum of " + @album.sample_album.max_page
      redirect_to album_photos_photos
    else    
      # add a page to the album
      # number of photos based on the album photos per page
      @album.sample_album.photo_per_page.times do
        @photo = Photo.new
        @photo.album = @album
        @photo.photo_number = @album.photos.count + 1
        @photo.save
      end
      flash.now[:notice] = "Page is added."
    end
    
    
    
    respond_to do |format|
      format.js{redirect_to album_photos_path(page: params[:page])}
    end
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
  
  def update_memo
    @album = Album.friendly.find(params[:album_id])
    @photo = Photo.find(params[:id])
    @photo.memo = params[:memo]
    @photo.save
  end

  def update_photos
    # save album photos with ajax request
    case
    # image drop to empty album photo
    when params[:type] == "Append"
      @photo = Photo.find(params[:photo_id])
      @target_picture = Picture.find(params[:target_picture_id])
      @target_photo = @target_picture.photo
      # assign target picture to empty album photo
      @photo.picture = @target_picture
      @photo.picture_id = @target_picture.id
      @photo.save
      
    # image remove from album photo
    when params[:type] == "Remove"
      @picture = Picture.find(params[:target_picture_id])
      @photo = Photo.find(params[:photo_id])
      @photo.picture = nil
      @photo.picture_id = nil
      @photo.save
   # image swap
   when params[:type] == "Swap"
      @photo = Photo.find(params[:photo_id])
      @picture = @photo.picture
      @target_picture = Picture.find(params[:target_picture_id])
      @target_photo = @target_picture.photo
   
      # if image from album photo
      if @target_photo
        @target_photo.picture = nil
        @photo.picture = @target_picture
        @photo.picture_id = @target_picture.id
        @photo.save
        @target_photo.picture = @picture
        @target_photo.picture_id = @picture.id
        @target_photo.save
      else
        @photo.picture = @target_picture
        @photo.picture_id = @target_picture.id
        @photo.save
      end
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
      redirect_to album_photos_path+"?page="+(@photo.photo_number.to_f/@album.sample_album.photo_per_page).ceil.to_s
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
      redirect_to album_photos_path+"?page="+(@photo.photo_number.to_f/@album.sample_album.photo_per_page).ceil.to_s
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
    
    # update photo number after deleting
    @album.photos.each do |photo|
      if photo.photo_number > @photo_number
        photo.photo_number -= 1
        photo.save
      end
    end

    flash[:notice] = "Photo was delete. belonging image back to photo box."
    @photo.destroy

    redirect_to album_photos_path+"?page="+(@photo_number.to_f/@album.sample_album.photo_per_page).ceil.to_s
  end

  private

  def photo_params
    params.require(:photo).permit(:memo, :picture, 
      :picture_crop_x, :picture_crop_y, :picture_crop_w, :picture_crop_h)
  end
 
end
