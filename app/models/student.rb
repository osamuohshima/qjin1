class Student < ActiveRecord::Base
  has_many :student_nenjis, :dependent => :destroy
  belongs_to :users, :class_name => 'User', :foreign_key =>'user_id'

end
