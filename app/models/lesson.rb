class Lesson < ApplicationRecord
  belongs_to :topic

  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words

  accepts_nested_attributes_for :lesson_words, allow_destroy: true,
    reject_if: :invalid_fields?

  scope :recent, ->{order created_at: :desc}

  private

  def invalid_fields? attributes
    word_attributes = attributes["word_attributes"]
    def_attributes = word_attributes["definitions_attributes"].values[0]
    word_attributes["text"].blank? || def_attributes["text"].blank?
  end
end
