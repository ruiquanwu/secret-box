class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :photo
  mount_uploader :context, PhotoUploader
end
