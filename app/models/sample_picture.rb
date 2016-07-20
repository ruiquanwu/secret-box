class SamplePicture < ActiveRecord::Base
  def self.Sizes
    {"4x6" => "4x6", "5x7" => "5x7"}
  end
end
