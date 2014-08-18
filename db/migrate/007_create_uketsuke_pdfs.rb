class CreateUketsukePdfs < ActiveRecord::Migration
  def self.up
    create_table :uketsuke_pdfs do |t|
        t.column :ukestuke_bango, :integer
        t.column :pdf_name, :string
        t.column :ukestuke_nen, :integer
    end 
    
  end

  def self.down
    drop_table :uketsuke_pdfs
  end
end
