class SampleAlbum < ActiveRecord::Base
  mount_uploader :avatar, AlbumAvatarUploader
  mount_uploader :album_layout, AlbumLayoutUploader
  
  
  def format_features
    result = "<ul id='album_attrs'>"
    features = self.features.split(';')
    features.each do |feature|
      result += "<li id='album_attr'>" + feature + "</li>"
    end
    result += "</ul>"
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
    specifications
  end
  
  def format_specifications
    result = "<table class='table'>"
    self.specifications.each_with_index do |(key, value), index|
      if index%2 == 0
        result += "<tr class='even-row'>"
      else
        result += "<tr class='odd-row'>"
      end
        result += "<td class='cell'>" + key.to_s + ":</td>"
        result += "<td class='cell'>" + value.to_s + "</td>"
        result += "</tr>"
    end    
    result += "</table>"
  end
  
end
