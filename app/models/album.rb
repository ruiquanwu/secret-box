class Album < ActiveRecord::Base
  extend FriendlyId
  
  validates :name, presence: true
  validates :description, presence: true
  validates :style, presence: true
  
  after_create :append_first_page
  
  friendly_id :name, use: :slugged
  belongs_to :user
  belongs_to :sample_album
  has_many :photos, dependent: :destroy
  has_many :pictures, dependent: :nullify
  has_many :orders
  mount_uploader :avatar, AlbumAvatarUploader
  mount_uploader :album_layout, AlbumLayoutUploader

  # scope to show Album sample
  scope :album_samples, -> {Album.where('user is NULL')}

  def should_generate_new_friendly_id?
    name_changed?
  end
  
  def max_photos
    self.sample_album.max_page * self.sample_album.photo_per_page
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
