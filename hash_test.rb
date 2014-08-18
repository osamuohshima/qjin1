require	"rubygems"
require_gem	"activerecord"
ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :host => "localhost",
  :username => "root",
  :password => "",
  :database => "qjin_development"
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
p    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
p    uketsuke.uketsuke_nen=1999
p    uketsuke.uketsuke_bango =uketsuke_moto.uke1999
    uketsuke.save
   end
 uke_nen="uke2000"
 eval  " if uketsuke_moto.#{uke_nen}!=0  then ( \n "
    uketsuke = UketsukeRireki.new
    uketsuke.kigyo_bango=uketsuke_moto.kigyo_bango
p  uketsuke.uketsuke_nen = 'uke'+uke_nen[3..4]
p eval " uketsuke.uketsuke_bango =uketsuke_moto.#{uke_nen}\n"
    uketsuke.save
eval "end\n"


 i=i+1
end

#p uketsuke.uketsuke_bango



