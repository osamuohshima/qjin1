class CreateKigyoInfos < ActiveRecord::Migration
  def self.up
    create_table :kigyo_infos do |t|
    end
  end

  def self.down
    drop_table :kigyo_infos
  end
end
