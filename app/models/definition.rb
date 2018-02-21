class Definition < ApplicationRecord
  belongs_to :word

  validates :text, presence: true
  validates :word, presence: true

  scope :correct, ->{where correct: true}
end
