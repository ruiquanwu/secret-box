class PhotosController < ApplicationController

  def index
    @album = Album.find(params[:album_id])
    @photos = @album.photos.album_photos.paginate(page: params[:page], per_page: @album.photo_per_page)
    @available_photos = @album.photos.freephotos#.limit(10)
  end

  def show
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])
  end

  def new
    @album = Album.find(params[:album_id])
    @photo = @album.photos.new
  end

  def create
    @album = Album.find(params[:album_id])
    if @album.photos.album_photos.find_by_picture(nil)
      @render_page = @album.photos.album_photos.find_by_picture(nil).photo_number
    else
      @render_page = @album.photos.album_photos.count + 1
    end

    # assign every uploaded picture file to freephotos
    params[:photo][:picture].each do |picture|
      @photo_in_panel = Photo.new(:picture => picture)
      @photo_in_panel.album = @album
      # photos in album should have the same number as (freephotos + back-up freephotos)
      if @photo_in_panel.save
        if  @album.photos.freephotos.count + @album.photos.replace_photos.count > @album.photos.album_photos.count

          @photo_in_album = Photo.new
          @photo_in_album.album = @album
          @photo_in_album.photo_number = @album.photos.album_photos.count + 1
          @photo_in_album.save
        end
      else
        render :new
      end
    end
    redirect_to album_photos_path+"?page="+(@render_page.to_f/@album.photo_per_page).ceil.to_s

  end

  def crop
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])


    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])

    # Move freephotos from Pannel to Album
    if params[:type] == "Freephotos"
      @photo_to_album = Photo.find(params[:replace_photo_id])

      if @photo.photo_number != params[:photo_number].to_i
        @current_photo = Photo.find_by_photo_number(params[:photo_number])
      else
        @current_photo = @photo
      end
      #if @photo.picture
        #switch freephoto and photo
        @photo_to_album.photo_number = @current_photo.photo_number
        @photo_to_album.memo = @current_photo.memo
        @photo_to_album.save

        @current_photo.photo_number = nil
        @current_photo.save
    # Swap different photos in Album
    elsif params[:type] == "Photos"
      @photo_to_photo = Photo.find(params[:replace_photo_id])
      if @photo_to_photo.photo_number != params[:photo_number].to_i
        @photo.photo_number = @photo_to_photo.photo_number
        @photo.memo = @photo_to_photo.memo
        @photo.save
        @photo_to_photo.photo_number = params[:photo_number].to_i
        @photo_to_photo.save
      end
    else
      # Move photo from album to Panel
      if @photo.picture
        #byebug
        if @photo.photo_number != params[:photo_number].to_i
          @current_photo = Photo.find_by_photo_number(params[:photo_number])
        else
          @current_photo = @photo
        end

        @photo_to_freephoto = @album.photos.replace_photos.first
        @photo_to_freephoto.photo_number = @current_photo.photo_number
        @photo_to_freephoto.save

        @current_photo.photo_number = nil
        @current_photo.save
      end
    end

    respond_to do |format|
      format.js
    end

   # if @photo.update(photo_params)
    #  flash[:notice] = "Photo was updated"
    #  redirect_to album_photos_path+"?page="+(@photo.photo_number.to_f/@album.photo_per_page).ceil.to_s
   # else
    #  flash[:notice] = "Error on updating photo"
    #  redirect_to edit_album_photo_path
   # end
  end

  def update_memo
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])

    @photo.memo = params[:memo_body]
    @photo.save

    respond_to do |format|
      format.js
    end
  end

  def edit
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])
  end

  def insert
    @album = Album.find(params[:album_id])
    @current_photo = Photo.find(params[:id])
    @photo = @album.photos.new
    @photo_number = @current_photo.photo_number
    #@current_photo.photo_number = @current_photo.photo_number + 1
    #@current_photo.save

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
    @album = Album.find(params[:album_id])
    @current_photo = Photo.find(params[:id])
    @photo = @album.photos.new
    @photo_number = @current_photo.photo_number + 1
    #@current_photo.save

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
    @album = Album.find(params[:album_id])
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
