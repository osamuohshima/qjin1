require	"rubygems"
require 'active_record' 

ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :host => "localhost",
  :database => "qjin_development",
  :socket => "/var/run/mysqld/mysqld.sock"
)

class KigyoDaicho < ActiveRecord::Base
end

mondai_char="－"
teisei_char="ー"
#mondai_columns=["jigyosho_mei1","jigyosho_mei2","furikana"]
mondai_columns="jigyosho_mei1"

#mondai_columns.each{|column|
  condition=['jigyosho_mei1 like ?', "－"]
  kigyos = KigyoDaicho.find(:all, :conditions => condition)
  kigyos.each{|kigyo|
p  kigyo
    kigyo.#{column}= kigyo.#{column}.tr("－","ー")
    kigyo.save
  }  

#}

