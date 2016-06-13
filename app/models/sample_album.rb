class SampleAlbum < ActiveRecord::Base
  mount_uploader :avatar, AlbumAvatarUploader
  mount_uploader :album_layout, AlbumLayoutUploader
end
