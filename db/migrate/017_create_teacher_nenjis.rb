class CreateTeacherNenjis < ActiveRecord::Migration
  def self.up
    create_table :teacher_nenjis do |t|
      t.column :name,                      :string
      t.column :nendo,                     :integer
      t.column :bunshou,                   :string, :limit => 40
      t.column :gakunen,                   :integer
      t.column :kyoka,                     :string
      t.column :updated_at,                :datetime
      t.column :teacher_id,                :integer
    end
  end

  def self.down
    drop_table :teacher_nenjis
  end
end
