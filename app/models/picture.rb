class Picture < ActiveRecord::Base
  
  before_update :rotate_image, if: :image_rotate?
  
  belongs_to :user
  belongs_to :album
  belongs_to :photo
  mount_uploader :context, PhotoUploader
  
  def image_rotate?
    self.rotate_landscape_changed? || self.rotate_portrait_changed?
  end
  
  def rotate_image
    self.context.recreate_versions!
  end
end
