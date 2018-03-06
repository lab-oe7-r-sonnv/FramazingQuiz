class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :confirmable, :validatable

  has_many :lessons, dependent: :destroy

  enum sex: %i(male female)
  enum type: {Student: "Student", Teacher: "Teacher", Admin: "Admin"}

  validates :name, presence: true

  def current_user? user
    self == user
  end
end
