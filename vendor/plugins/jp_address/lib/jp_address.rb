require 'open-uri'
require 'rexml/document'
#
# Model
# attributes:
#   jiscode
#   zipcode_old
#   zipcode
#   prefecture
#   city
#   address
#
class JpAddress < ActiveRecord::Base
  establish_connection :jp_address
  set_table_name  "jp_address"
  set_primary_key "zipcode"
  
  @@config = {}
  mattr_reader :config
  
  def self.config=(options)
    @@config = options
  end
  
  # Search by (old|new) zipcode and any string
  # Usage1 :: Search by old type Zipcode when code.length is 3 or 5
  # Usage2 :: Search by normal Zipcode code.length is 7
  # ATTENTION :: code must be String!!
  def self.[](key)
    key.delete("-")
    if key =~ /[0-9]/
      case key.length
        when 3 then find_all_by_zipcode_old(key)
        when 5 then find_all_by_zipcode_old(key)
        when 7 then find(key)
      end
    else
      conditions =<<EOS
prefecture LIKE '%#{key}%' OR
city LIKE '%#{key}%' OR
address LIKE '%#{key}%'
EOS
      find(:all, :conditions => conditions)
    end
  rescue
    nil
  end
  
  # Get url for search result page of GoogleMaps
  def googlemaps_url
    "http://maps.google.com/maps?f=q&hl=ja&q=#{ERB::Util.url_encode(prefecture+city+address)}&ie=UTF8&z=16&iwloc=addr"
  end
  
  # Get latitude and longitude via Post2geo API (http://nyanjiro.no-blog.jp/web20/2007/07/post_df4b.html)
  def geocode
    Geocode.find_by_address("#{prefecture}#{city}#{address}")
  end
  
  #  InnerClass for Geocode
  class Geocode
    GOOGLE_MAPS_KEY = YAML.load_file(File.expand_path(File.join(RAILS_ROOT, 'vendor/plugins/jp_address/config/googlemaps.yml')))['key']
    GOOGLE_MAPS_URL = "http://maps.google.com/maps/geo?key=#{GOOGLE_MAPS_KEY}&output=xml&"
    
    attr_accessor :latitude, :longitude, :address, :country_code, :address_line
    
    def self.find_by_address(address)
      geo = Geocode.new
      geo.geocode(address)
      geo
    end
    
    def geocode(address)
      open(GOOGLE_MAPS_URL + "q=#{ERB::Util.url_encode(address)}") do |response|
        xml = REXML::Document.new(response.read)
        if xml.elements['/kml/Response/Status/code'].text == '200'
          self.country_code = xml.elements['/kml/Response/Placemark/AddressDetails/Country/CountryNameCode'].text
          self.address_line = xml.elements['/kml/Response/Placemark/AddressDetails/Country/AddressLine'].text
          geocode_array     = xml.elements['/kml/Response/Placemark/Point/coordinates'].text.split(/,/)
          self.latitude     = geocode_array[0]
          self.longitude    = geocode_array[1]
        end
      end
    end
    
  end
  
  # Called from migration and rake task.
  def self.insert_from_csv
    require 'fastercsv'
    require 'ar-extensions'
    require 'kconv'
    $KCODE='j'
    
    csv_file = File.expand_path(File.join(RAILS_ROOT, 'vendor', 'plugins', 'jp_address', 'ken_all.csv'))
    
    puts "Reading " + csv_file
    puts "This file is over 12MB, please wait ..."
    address_list = Array.new
    FasterCSV.foreach(csv_file) do |data|
      address_list << [ 
      data[0], # JISCODE(5)
      data[1], # ZIPCODE_OLD(3)
      data[2], # ZIPCODE(7)
      data[6].toutf8, # PREFECTURE
      data[7].toutf8, # CITY
      data[8].toutf8.gsub(/^[０-９].*$|（.*$/u,"") # ADDRESS
      ] unless data[2]=~/^[0-9]{6}0$/
    end
    
    puts "Store all data into static_addresses table."
    puts "There are over 120,000 rows, please wait ..."
    column = [:jiscode, :zipcode_old, :zipcode, :prefecture, :city, :address]
    JpAddress.import(column, address_list, :optimize => true)
  end
  
end