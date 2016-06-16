class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :freephotos, dependent: :destroy
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
  end
  
end
