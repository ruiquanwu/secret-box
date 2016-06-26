class Photo < ActiveRecord::Base
  attr_accessor :picture_crop_x, :picture_crop_y, :picture_crop_w, :picture_crop_h
  belongs_to :album
  has_one :picture
  #mount_uploader :picture, PhotoUploader
  #crop_uploaded :picture

  # scope to show every photo in album
  scope :album_photos, -> { Photo.where('photo_number is not NULL').order('photo_number ASC') }
  # scope to show every photo in freephotos pannel
  scope :freephotos, -> { Photo.where('photo_number is NULL AND  picture is NOT NULL') }
  # scope to show every replace spot for freephoto, these photos are not visible in the page
  scope :replace_photos, -> { Photo.where('photo_number is NULL AND  picture is NULL') }

  def self.update_photo_number(album, photo_number)
    album.photos.each do |photo|
    if photo.photo_number && photo.photo_number >= photo_number
        photo.photo_number = photo.photo_number + 1
        photo.save
    end
  end
      
  end

end
