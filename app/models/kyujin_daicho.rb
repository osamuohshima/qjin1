class KyujinDaicho < ActiveRecord::Base
  belongs_to(:kigyo_info)
  belongs_to(:uketuke_pdf)
  belongs_to(:kyujin_uketsuke)

  validates_numericality_of :kigyo_bango, :sangyo_code
end
