require	"rubygems"
require 'active_record' 

ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :host => "localhost",
  :database => "qjin_development",
  :socket => "/var/run/mysqld/mysqld.sock"
)
class UketsukeRirekiMoto < ActiveRecord::Base
end
class UketsukeRireki < ActiveRecord::Base
end

#uketsuke_moto=UketsukeRirekiMoto.new

first_year = 1999
last_year = 2005

uketsuke_motos=  UketsukeRirekiMoto.find(:all)
for uketsuke_moto in uketsuke_motos
  (first_year..last_year).each do |year|

   uketsuke_moto_bango = uketsuke_moto.send("uke#{year}")
     if uketsuke_moto_bango !=0 then
       uketsuke = UketsukeRireki.new(
       :kigyo_bango => uketsuke_moto.kigyo_bango,
       :uketsuke_nen => year,
       :uketsuke_bango =>uketsuke_moto_bango)
#p  uketsuke_moto.kigyo_bango,uketsuke_moto_bango
       uketsuke.save
    end
  end
end
