class ServiceLookup < ActiveRecord::Base
  def self.Categories
    {:option => "option", :shipment => "shipment"}
  end
  
  def self.PriceLookup name
    ServiceLookup.find_by_name(name).price
  end
end
