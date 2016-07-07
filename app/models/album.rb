class Album < ActiveRecord::Base
  belongs_to :user
  belongs_to :sample_album
  has_many :photos, dependent: :destroy
  has_many :freephotos, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :order
  mount_uploader :avatar, AlbumAvatarUploader
  mount_uploader :album_layout, AlbumLayoutUploader

  # scope to show Album sample
  scope :album_samples, -> {Album.where('user is NULL')}

  def setAttributes(sample_album)
    self.style = sample_album.id
    self.description = sample_album.description
    self.features = sample_album.features
    self.has_memo = sample_album.has_memo
    self.avatar = sample_album.avatar
    self.album_layout = sample_album.album_layout
    self.max_page = sample_album.max_page
    self.photo_per_page = sample_album.photo_per_page
    self.orientation = sample_album.orientation
    self.number_in_stock = sample_album.number_in_stock
    self.price = sample_album.price
    self.color = sample_album.color
    self.photo_size = sample_album.photo_size
  end
  
  def max_photos
    self.max_page * self.photo_per_page
  end
  
  def photos_inserted
    self.pictures.where.not("photo_id" => nil)
  end
  
  def remains_photos
    self.max_photos - self.photos_inserted.count
  end
  
  def progress_percentage
    (self.photos_inserted.count/self.max_photos.to_f * 100).round(2).to_s + "%"
  end
  
  def progress_background
    if self.photos_inserted.count/self.max_photos.to_f.round(2) > 0.5
      color = "green"
    else
      color = "red"
    end
    color
  end
  
end
