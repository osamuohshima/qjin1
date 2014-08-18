class CreateKyujinUketsukes < ActiveRecord::Migration
  def self.up
    create_table :kyujin_uketsukes do |t|
    end
  end

  def self.down
    drop_table :kyujin_uketsukes
  end
end
