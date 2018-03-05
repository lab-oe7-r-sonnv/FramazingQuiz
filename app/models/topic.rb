class Topic < ApplicationRecord
  belongs_to :creator, class_name: User.name, inverse_of: :topics

  has_many :lessons, dependent: :destroy
end
