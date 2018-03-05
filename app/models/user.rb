class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :confirmable

  has_many :topics, dependent: :destroy, foreign_key: :creator_id,
    inverse_of: :creator
  has_many :lessons, through: :topics

  enum sex: %i(male female)
  enum type: {Student: "Student", Teacher: "Teacher", Admin: "Admin"}
end
