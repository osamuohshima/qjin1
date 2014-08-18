class StudentNenji< ActiveRecord::Base
	belongs_to :student, :foreign_key => 'student_id'
end
