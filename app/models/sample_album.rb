class SampleAlbum < ActiveRecord::Base
  mount_uploader :avatar, AlbumAvatarUploader
  mount_uploader :album_layout, AlbumLayoutUploader
  has_many :albums
  
  
  def format_features
    result = "<ul id='album_attrs' class='list-group'>"
    features = self.features.split(';')
    features.each do |feature|
      result += "<li id='album_attr' class='list-group-item'>" + feature + "</li>"
    end
    result += "</ul>"
  end
  
  def self.format_features_array
    ary = []
    sample_albums = SampleAlbum.all
    sample_albums.each do |sample_album|
      ary << sample_album.format_features
    end
    ary
  end
  
  def specifications
    specifications = {}
    specifications[:orientation] = self.orientation
    specifications[:color] = self.color
    specifications[:max_page] = self.max_page
    specifications[:photo_per_page] = self.photo_per_page
    specifications[:has_memo] = self.has_memo
    specifications[:number_in_stock] = self.number_in_stock
    specifications[:price] = self.price
    specifications[:photo_size] = self.photo_size
    specifications
  end
  
  
end
