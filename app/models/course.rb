class Course < ApplicationRecord
  belongs_to :teacher, class_name: User.name, inverse_of: :courses

  has_many :student_courses, dependent: :destroy
  has_many :course_lessons, dependent: :destroy
  has_many :students, through: :student_courses
  has_many :lessons, through: :course_lessons
end
