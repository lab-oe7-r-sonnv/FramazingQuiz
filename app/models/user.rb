class User < ApplicationRecord
  has_many :topics, dependent: :destroy, foreign_key: :creator_id,
    inverse_of: :creator
  has_many :lessons, through: :topics

  has_secure_password
end
