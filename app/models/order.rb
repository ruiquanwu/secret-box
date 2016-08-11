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
  
  def self.display_options
    options_hash = {}
    options = ServiceLookup.where(categories: "option")
    options.each do |option|
      options_hash[option.name] = option.price
    end
    options_hash
  end
  
  def calculate_total
    total = 0
    # Album price
    total += SampleAlbum.find(self.album.style).price
    
    # Pictures price
    total += self.picture_total_price
    
    # Option price
    if self.options
      self.options.each do |option|
        total += ServiceLookup.find_by_name(option).price
      end
    end
    
    # Shipment price
    shipment = ServiceLookup.find_by_name(self.shippment)
    total += shipment.price
    
    self.total_price = total.round(2)
  end
  
  def picture_size
    self.album.sample_album.photo_size
  end
  
  def picture_price
    SamplePicture.find_by_size(self.picture_size).price
  end
  
  def picture_number
    self.album.pictures.count
  end
  
  def picture_total_price
    (self.picture_price * self.picture_number).round(2)
  end
  
  def update_number_in_stock
    sample_album = self.album.sample_album
    if sample_album.number_in_stock > 0
      sample_album.number_in_stock -= 1
    end
    sample_album.save
  end
  
  def has_shpping_address?
    self.shipping_address
  end
  
  def trackable?
    self.status == "Shipped"
  end
  
  def tracking_link
    if self.carrier.downcase == "ups"
      link = "https://www.ups.com/WebTracking/track?track=yes&trackNums=" + self.track_number
    elsif self.carrier.downcase == "usps"
      link = "https://tools.usps.com/go/TrackConfirmAction?tLabels=" + self.track_number
    else
      link = "#"
    end
    link
  end
end
