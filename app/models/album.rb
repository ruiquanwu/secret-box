class Album < ActiveRecord::Base
  extend FriendlyId
  
  after_create :append_first_page
  
  friendly_id :name, use: :slugged
  belongs_to :user
  belongs_to :sample_album
  has_many :photos, dependent: :destroy
  #has_many :pictures, dependent: :destroy
  has_many :orders
  mount_uploader :avatar, AlbumAvatarUploader
  mount_uploader :album_layout, AlbumLayoutUploader

  # scope to show Album sample
  scope :album_samples, -> {Album.where('user is NULL')}

  def should_generate_new_friendly_id?
    name_changed?
  end
  
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
    self.sample_album.max_page * self.sample_album.photo_per_page
  end
  
  def pictures
    self.photos.where("picture_id is not null")
  end
  
  def remains_photos
    self.max_photos - self.pictures.count
  end
  
  def progress_percentage
    (self.pictures.count/self.max_photos.to_f * 100).round(2).to_s + "%"
  end
  
  def progress_background
    if self.pictures.count/self.max_photos.to_f.round(2) > 0.5
      color = "green"
    else
      color = "red"
    end
    color
  end
  
  def append_first_page
    # create first page for album
    self.sample_album.photo_per_page.times do
      photo = Photo.new
      photo.album = self
      photo.photo_number = self.photos.count + 1
      photo.save
    end
  end
  
  def is_portrait?
    self.sample_album.orientation == "portrait"
  end
  
end
