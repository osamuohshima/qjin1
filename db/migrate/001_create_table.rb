class CerateTables < ActiveRecord::Migration
  def self.up
#    drop_table :kigyo_daichos if :kigyo_daichos
    create_table(:kigyo_daichos) do |table|
      table.column :kigyo_bango, :integer
      table.column :jigyosho_mei1, :string, :limit =>128
      table.column :jigyosho_mei2, :string, :limit =>64
      table.column :furikana, :string, :limit =>128
      table.column :shozaichi, :string, :limit =>32
      table.column :yubin_zip, :integer
      table.column :shozaichi1, :string, :limit =>128
      table.column :shozaichi2, :string, :limit =>64
      table.column :tantou_yaku, :string, :limit =>64
      table.column :tantou_mei, :string, :limit =>32
      table.column :tele_number, :string, :limit =>32
      table.column :sangyo_code, :integer
      table.column :seisan_hinmoku, :string, :limit =>256
      table.column :input_date, :datetime
    end
#    drop_table :kyujin_uketsukes if :kyujin_uketsukes
    create_table(:kyujin_uketsukes) do |table|
      table.column :uketuke_date, :string, :limit =>16
      table.column :uketuke_code, :string, :limit =>8
      table.column :uketuke_bango, :integer
      table.column :kigyo_bango, :integer
      table.column :shokushu_bango, :integer
      table.column :shokushu_mei, :string, :limit =>128
      table.column :shokugyo_code, :integer
      table.column :tenkin, :integer
      table.column :koutai, :integer
      table.column :kihonkyu, :integer
      table.column :kijunnai_tingin, :integer
      table.column :kikai, :string, :limit =>4
      table.column :denki, :string, :limit =>4
      table.column :joho, :string, :limit =>4
      table.column :kouka, :string, :limit =>4
      table.column :kenchiku, :string, :limit =>4
      table.column :kei, :integer
      table.column :kyujin_sosu, :integer
      table.column :sintai, :integer
      table.column :kengaku, :integer
      table.column :heigan, :integer
      table.column :remark, :string, :limit =>128
      table.column :irai_jikou,:string, :limit =>256
      table.column :input_date, :datetime
    end
#    drop_table :kigyo_infos if :kigyo_infos
    create_table(:kigyo_infos) do |table|
      table.column :kigyo_bango, :integer
      table.column :sangyo_code, :integer
      table.column :jugyoinsu, :integer
      table.column :sihon_oku, :integer
      table.column :sihon_senman, :integer
      table.column :input_date, :datetime
    end
#    drop_table :uketsuke_pdfs if :uketsuke_pdfs
    create_table(:uketsuke_pdfs) do |table|
      table.column :kigyo_bango, :integer
      table.column :uketuke_code, :string, :limit =>8
      table.column :pdf_file_name, :string, :limit =>32
      table.column :input_date, :datetime
    end 
  end

  def self.down
    drop_table :kigyo_daichos
    drop_table :kyujin_uketsukes
    drop_table :kigyo_infos
    drop_table :uketsuke_pdfs
  end
end
