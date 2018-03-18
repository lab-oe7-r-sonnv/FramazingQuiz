class Topic < ApplicationRecord
  belongs_to :creator, class_name: User.name, inverse_of: :topics

  has_many :lessons, dependent: :nullify

  validates :name, presence: true
  validates :creator, presence: true

  scope :recent, ->{order created_at: :desc}
end
