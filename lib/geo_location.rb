require 'geokit'

module GeoLocation
  def self.included(base)
    base.extend GeoLocation::ClassMethods
  end

  module ClassMethods
    def has_geo_location(name)
      write_inheritable_attribute(:geo_location_definitions, {}) if geo_location_definitions.nil?
      geo_location_definitions[:name] = name

      before_save :retrive_location

      key "#{name}_ip".to_sym, String, :required => true
      key "#{name}_lat".to_sym, Float
      key "#{name}_lng".to_sym, Float
      key "#{name}_address".to_sym, String
    end

    def geo_location_definitions
      read_inheritable_attribute(:geo_location_definitions)
    end
  end

  def retrive_location
    name = self.class.geo_location_definitions[:name]
    if (ENV['RAILS_ENV'] == 'production')
      ip = self["#{name}_ip"]
    else
      ip = '128.189.211.230'
    end
    
    geo_loc = Geokit::Geocoders::MultiGeocoder.geocode(ip)

    if geo_loc.success
      self["#{name}_lat"] = geo_loc.lat
      self["#{name}_lng"] = geo_loc.lng

      res = Geokit::Geocoders::MultiGeocoder.reverse_geocode([geo_loc.lat, geo_loc.lng])
      self["#{name}_address"] = res.full_address
    end
  end
end