class Diary < ActiveRecord::Base
  belongs_to :user
  
  default_scope { order('created_at DESC') }
  
  def bodyOverView
    body[0..100]
  end
end
