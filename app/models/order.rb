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
      options_hash[option.name.capitalize] = option.price
    end
    options_hash
  end
  
  def calculate_total
    total = 0
    # Album price
    total += SampleAlbum.find(self.album.style).price
    
    # If has Front Cover
    if self.album.front_cover
      total += self.picture_price
    end
    
    # Pictures price
    total += self.picture_total_price
    
    # Option price
    if self.options
      self.options.each do |option|
        total += ServiceLookup.find_by_name(option.downcase).price
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
  
  def paypal_url(return_path, notify_path)
    values = {
        business: ENV['PAYPAL_SELLER'],
        cmd: "_xclick",
        upload: 1,
        return: "#{ENV['APP_HOST']}#{return_path}",
        invoice: id,
        amount: self.total_price,
        item_name: "Secret Albums #{self.album.name}",
        quantity: '1',
        notify_url: "#{ENV['APP_HOST']}#{notify_path}"

    }
    "#{ENV['PAYPAL_HOST']}/cgi-bin/webscr?" + values.to_query
  end
  
  def paypal_valid?(params, raw_post)
    uri = URI.parse(ENV['PAYPAL_HOST'] + '/cgi-bin/webscr?cmd=_notify-validate')
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    response = http.post(uri.request_uri, raw_post).body
    
    raise StandardError.new("Faulty paypal result: #{response}") unless ["VERIFIED", "INVALID"].include?(response)
    raise StandardError.new("Invaild IPN: #{response}") unless response == "VERIFIED"
    
    true
  end
end
