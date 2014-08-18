class CreateKyujinDaicho < ActiveRecord::Migration
  def self.up
    create_table :kyujin_daichos do |t|
        t.column :kujin_uketuke_id,               :integer
        t.column :kujin_uketuke_uketsuke_nen,     :integer
        t.column :kujin_uketuke_uketsuke_code,    :string
        t.column :kujin_uketuke_uketsuke_date,    :string
        t.column :kujin_uketuke_uketsuke_bango,   :integer
        t.column :kujin_uketuke_kigyo_bango,      :integer
        t.column :kujin_uketuke_shokushu_bango,   :integer
        t.column :kujin_uketuke_shokushu_mei,     :string
        t.column :kujin_uketuke_shokyugyo_code,   :integer
        t.column :kujin_uketuke_tenkin,           :integer
        t.column :kujin_uketuke_koutai,           :integer
        t.column :kujin_uketuke_kihonkyu,         :integer
        t.column :kujin_uketuke_kijunnai_tingin,  :integer
        t.column :kujin_uketuke_kikai,            :string
        t.column :kujin_uketuke_denki,            :string
        t.column :kujin_uketuke_joho,             :string
        t.column :kujin_uketuke_kouka,            :string
        t.column :kujin_uketuke_kenchiku,         :string
        t.column :kujin_uketuke_kei,              :integer
        t.column :kujin_uketuke_kyujin_sosu,      :integer
        t.column :kujin_uketuke_shintai,          :integer
        t.column :kujin_uketuke_kengaku,          :integer
        t.column :kujin_uketuke_bikou,            :string

        t.column :kigyo_info_sangyo_code,         :integer
        t.column :kigyo_info_jugyoinsu,           :integer
        t.column :kigyo_info_sihon_oku,           :integer
        t.column :kigyo_info_sihon_senman,        :integer

        t.column :kigyo_daicho_jigyosho_mei1,     :string
        t.column :kigyo_daicho_jigyosho_mei2,     :string
        t.column :kigyo_daicho_shozaichi,         :string
        t.column :kigyo_daicho_seisan_hinmoku,    :string

        t.column :uketsuke_pdfs_pdf_file_name,    :string
			end

		 add_index :kyujin_daichos, [:kyujin_uketsuke_id, :kigyo_info_id, :uketsuke_pdfs]
     add_index :kyujin_daichos, :uketsuke_pdfs_id
  end

  def self.down
    drop_table :kyujin_daichos
  end
end
