# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # endß

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  # process :resize_to_fill => [2816, 1876]
  # process :resize_to_limit => [960, 640]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  process resize_to_fill(900, 600, gravity='Center')

  version :portrait do
    process :auto_orient
    process resize_to_fill(600, 900, gravity='Center')
  end
=begin
  version :thumb do
    process crop: :picture


  image = MiniMagick::Image::read(File.binread(@file.file))
    if image[:width] > image[:height]
    # original is landscape
      resize_to_fill(738, 492)
    else
    # original is portrait
      resize_to_fit(738, 492)
    end

    process resize_to_limit: [1200, 800]
  end
=end
  def is_landscape? picture
    image = MiniMagick::Image.open(picture.path)
    image[:width] > image[:height]
  end

  def auto_orient
    manipulate! do |img|
      img = img.auto_orient
    end
  end
  # version :normal do
  #   process resize_to_fill: [900, 600]
  # end
 
  version :profile do
    process resize_to_fill: [180, 120]
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
