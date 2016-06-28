class Photo < ActiveRecord::Base
  attr_accessor :picture_crop_x, :picture_crop_y, :picture_crop_w, :picture_crop_h
  belongs_to :album
  has_one :picture
  #mount_uploader :picture, PhotoUploader
  #crop_uploaded :picture

  def self.default_scope
    Photo.all.order('photo_number ASC')
  end

  def self.update_photo_number(album, photo_number)
    album.photos.each do |photo|
    if photo.photo_number && photo.photo_number >= photo_number
        photo.photo_number = photo.photo_number + 1
        photo.save
    end
  end
      
  end

end
