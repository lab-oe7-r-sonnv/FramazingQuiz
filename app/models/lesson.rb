class Lesson < ApplicationRecord
  belongs_to :topic

  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words
end
