class CreateJpAddress < ActiveRecord::Migration
  
  def self.up
    create_table :jp_address do |t|
      t.column :jiscode,          :string, :null => false, :limit => 5
      t.column :zipcode_old,      :string, :null => false, :limit => 5
      t.column :zipcode,          :string, :null => false, :limit => 7
      t.column :prefecture,       :string, :null => false
      t.column :city,             :string, :null => false
      t.column :address,          :string, :null => true
    end
    add_index :jp_address, :jiscode
    add_index :jp_address, :zipcode_old
    add_index :jp_address, :zipcode
    
    JpAddress::insert_from_csv
  end
  
  def self.down
    drop_table :jp_address
  end
end