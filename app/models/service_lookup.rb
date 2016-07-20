class ServiceLookup < ActiveRecord::Base
  def self.Categories
    {:option => "option", :shipment => "shipment"}
  end
end
