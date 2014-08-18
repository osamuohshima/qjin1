class AddShokushuBangoToUketsukePdfs < ActiveRecord::Migration
  def self.up
     add_column(:uketsuke_pdfs, :shokushu_bango, :integer)
  end

  def self.down
    remove_column(:uketsuke_pdfs, :shokushu_bango)
  end
end
