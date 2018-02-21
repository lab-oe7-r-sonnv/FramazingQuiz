class LessonWord < ApplicationRecord
  belongs_to :lesson
  belongs_to :word

  validates :lesson, presence: true
  validates :word, presence: true

  accepts_nested_attributes_for :word
end
