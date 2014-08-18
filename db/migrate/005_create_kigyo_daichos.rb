class CreateKigyoDaichos < ActiveRecord::Migration
  def self.up
    create_table :kigyo_daichos do |t|
    end
  end

  def self.down
    drop_table :kigyo_daichos
  end
end
