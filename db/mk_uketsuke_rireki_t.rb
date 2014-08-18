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

uketsuke_moto=UketsukeRirekiMoto.new
i=1
while uketsuke_moto= UketsukeRirekiMoto.find(i)
  if uketsuke_moto.uke1999!=0 then
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
    uketsuke.uketsuke_nen=1999
    uketsuke.uketsuke_bango =uketsuke_moto.uke1999
    uketsuke.save
   end

  if uketsuke_moto.uke2000!=0 then
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
    uketsuke.uketsuke_nen=2000
    uketsuke.uketsuke_bango =uketsuke_moto.uke2000
    uketsuke.save
   end
  if uketsuke_moto.uke2001!=0 then
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
    uketsuke.uketsuke_nen=2001
    uketsuke.uketsuke_bango =uketsuke_moto.uke2001
    uketsuke.save
   end
  if uketsuke_moto.uke2002!=0 then
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
    uketsuke.uketsuke_nen=2002
    uketsuke.uketsuke_bango =uketsuke_moto.uke2002
    uketsuke.save
   end
  if uketsuke_moto.uke2003!=0 then
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
    uketsuke.uketsuke_nen=2003
    uketsuke.uketsuke_bango =uketsuke_moto.uke2003
    uketsuke.save
   end
  if uketsuke_moto.uke2004!=0 then
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
    uketsuke.uketsuke_nen=2004
    uketsuke.uketsuke_bango =uketsuke_moto.uke2004
    uketsuke.save
   end
  if uketsuke_moto.uke2005!=0 then
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
    uketsuke.uketsuke_nen=2005
    uketsuke.uketsuke_bango =uketsuke_moto.uke2005
    uketsuke.save
   end
  if uketsuke_moto.uke2006!=0 then
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
    uketsuke.uketsuke_nen=2006
    uketsuke.uketsuke_bango =uketsuke_moto.uke2006
    uketsuke.save
   end
  if ((uketsuke_moto.uke2007!=0) and (uketsuke_moto.uke2007!="") ) then
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
    uketsuke.uketsuke_nen=2007
    uketsuke.uketsuke_bango =uketsuke_moto.uke2007
    uketsuke.save
   end
  i=i+1
end
