class Freephoto < ActiveRecord::Base
  belongs_to :album
  mount_uploader :picture, FreePhotoUploader
end
