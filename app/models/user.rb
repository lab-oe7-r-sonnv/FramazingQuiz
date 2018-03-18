class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :confirmable, :validatable

  has_many :lessons, dependent: :destroy
  has_many :notifications, foreign_key: :user_id,
    inverse_of: :user, dependent: :destroy, class_name: Notification.name
  has_many :bookmarked_lessons, foreign_key: :bookmarker_id,
    inverse_of: :bookmarker, dependent: :destroy, class_name: Lesson.name
  has_many :topics, foreign_key: :creator_id,
    inverse_of: :creator, dependent: :destroy, class_name: Topic.name

  enum sex: %i(male female)
  enum type: {Student: "Student", Teacher: "Teacher", Admin: "Admin"}

  validates :name, presence: true
end
