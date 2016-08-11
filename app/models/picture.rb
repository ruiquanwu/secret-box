class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  mount_uploader :context, PhotoUploader
end
