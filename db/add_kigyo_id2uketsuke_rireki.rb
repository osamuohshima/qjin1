require	"rubygems"
require 'active_record' 

ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :host => "localhost",
  :database => "qjin_development",
  :socket => "/var/run/mysqld/mysqld.sock"
)
class UketsukeRireki < ActiveRecord::Base
end
class KigyoDaicho < ActiveRecord::Base
end

uketsuke_rirekis=UketsukeRireki.find(:all)
uketsuke_rirekis.each do |t| 
    @bango= t.kigyo_bango
    @daicho_data=  KigyoDaicho.find(:first,
        :conditions => ['kigyo_bango =?', @bango])
    t.kigyo_daicho_id = @daicho_data.id

     t.save
end

