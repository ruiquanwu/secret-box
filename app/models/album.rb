class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :freephotos, dependent: :destroy
  mount_uploader :avatar, AlbumAvatarUploader
  mount_uploader :album_layout, AlbumLayoutUploader

  # scope to show Album sample
  scope :album_samples, -> {Album.where('user is NULL')}

  def setAttributes
    self.front_cover = "/assets/PhotoAlbums" + self.style + ".jpg"
    case self.style
      when "1"
        self.orientation = "landscape"
        self.photo_per_page = 2
        self.max_page = 100
      when "2"
        self.orientation = "landscape"
        self.photo_per_page = 1
        self.max_page = 80
      when "3"
        self.orientation = "landscape"
        self.photo_per_page = 3
        self.max_page = 100
      when "4"
        self.orientation = "portrait"
        self.photo_per_page = 2
        self.max_page = 100
    end
  end
end
