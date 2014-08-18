class KigyoHomon < ActiveRecord::Base
  validates_presence_of :kigyo_bango, :senmon_kamei, :jigyosho_mei1,:kyujin_jokyo,:visit_date
end
