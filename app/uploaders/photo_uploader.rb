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

  # process the original image to landscape version
  process :process_landscape_version

  # rotate 180 to get landscape rotate version
  version :landscape_rotate do
    process :rotate_version
  end

  # portrait
  version :portrait do
    process :process_portait_version
  end
  
  # portrait rotate version
  version :portrait_rotate, from_version: :portrait_rotate do
    process :rotate_version
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
  
protected
  
  def rotate_image degree
    manipulate! do |img|
      img.rotate degree
      img
    end
  end
  
  def rotate_version
    manipulate! do |img|
      img.rotate 180
      img
    end
  end
  
  def process_landscape_version
    image = ::MiniMagick::Image::read(File.binread(@file.file))

    if image[:width] > image[:height]
        resize_to_fill 1200, 800
    else
      rotate_image "90"
      resize_to_fill 1200, 800
    end
  end
  
  # rotate back 90 degree to get portrait version
  def process_portait_version
    rotate_image "-90"
    resize_to_fill 800, 1200
  end

  
  
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
