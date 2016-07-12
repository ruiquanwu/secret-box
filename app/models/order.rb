class Order < ActiveRecord::Base
  extend FriendlyId
  friendly_id :user_name_and_album_name, use: :slugged
  before_save :calculate_total
  validates :shippment, presence: true
  
  serialize :options, Array
  belongs_to :user
  belongs_to :album
  has_one :shipping_address
  
  def user_name_and_album_name
    "#{self.user.name} Album #{self.album.name}"
  end
  
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
  
  def trackable?
    if self.status == "Shipped"
      true
    else
      false
    end
  end
  
  def tracking_link
    if self.carrier.downcase == "ups"
      link = "https://www.ups.com/WebTracking/track?track=yes&trackNums=" + self.track_number
    elsif self.carrier.downcase == "upsp"
      link = "https://tools.usps.com/go/TrackConfirmAction?tLabels=" + self.track_number
    else
      link = "#"
    end
    link
  end
end
