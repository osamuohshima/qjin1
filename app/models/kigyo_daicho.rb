class KigyoDaicho < ActiveRecord::Base
  has_many :uketsuke_rirekis
  belongs_to :kyujin_daicho
  has_many :kigyo_info
  has_many :kyujin_uketsukes

  validates_numericality_of :kigyo_bango, :greater_than => 19950000, :less_than =>2050
   


end
