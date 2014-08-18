class KigyoInfo < ActiveRecord::Base
  belongs_to :kigyo_daicho

  validates_presence_of :kigyo_number
  validates_numericality_of :kigyo_number, :jugyoinsu, :kigyo_daicho_id
end
