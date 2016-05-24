class FreephotosController < ApplicationController
  def index
  end

  def new
    @album = Album.find(params[:album_id])
    @freephoto = Freephoto.new
  end

  def create
    @album = Album.find(params[:album_id])
    #render plain: params[:freephoto][:picture].length.inspect
    @render_page = @album.photos.count + 1
    params[:freephoto][:picture].each do |photo|
      @freephoto = Freephoto.new(:picture => photo)
      @freephoto.album = @album

      if @freephoto.save
        @photo = Photo.new
        @photo.photo_number = @album.photos.count + 1
        @photo.album = @album
        @photo.save

      else
        render :new
      end
      #@album.freephotos.build(:picture => photo)
    end
    redirect_to album_photos_path+"?page="+"#{(@render_page.to_f/@album.photo_per_page).ceil}"
    
#    @freephoto = @album.freephotos.new(freephoto_param)

    puts @freephoto
  end

  private
  def freephoto_param
    params.require(:freephoto).permit(:picture)
  end
end
