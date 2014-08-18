class CreateKyujinPdfs < ActiveRecord::Migration
  def self.up
    create_table :kyujin_pdf do |t|
      t.column :kyujin_uketsuke_id, :integer
      t.column :uketsuke_pdf_id, :integer
    end
  end

  def self.down
    drop_table :kyujin_pdfs
  end
end
