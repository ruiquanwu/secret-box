class Order < ActiveRecord::Base
  validates :shippment, presence: true
  
  serialize :options, Array
  belongs_to :user
  belongs_to :album
  
  def calculate_total
    total = 0
    # Album price
    total += SampleAlbum.find(self.album.style).price
    
    # Pictures price
    total += self.picture_total_price
    
    # Option price
    if self.options.index("urgent-order-option")
      urgent_order = ServiceLookup.find_by_name("urgent-order-option")
      total += urgent_order.price
    end
    
    # Shipment price
    shipment = ServiceLookup.find_by_name(self.shippment)
    total += shipment.price
    
    self.total_price = total
  end
  
  def picture_size
    self.album.photo_size
  end
  
  def picture_price
    SamplePicture.find_by_size(self.picture_size).price
  end
  
  def picture_number
    self.album.photos_inserted.count
  end
  
  def picture_total_price
    self.picture_price * self.picture_number
  end
end
