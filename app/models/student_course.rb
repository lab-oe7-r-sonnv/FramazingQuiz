class StudentCourse < ApplicationRecord
  belongs_to :course
  belongs_to :student, class_name: User.name, inverse_of: :student_courses
end
