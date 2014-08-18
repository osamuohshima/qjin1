class UketsukePdf < ActiveRecord::Base
  belongs_to( :kyujin_uketsuke)
  validates_presence_of :pdf_name, :uketsuke_bango
end
