class Lesson < ApplicationRecord
  attr_reader :correct_words_ids, :incorrect_words_ids
  belongs_to :topic

  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words

  accepts_nested_attributes_for :lesson_words, allow_destroy: true,
    reject_if: :invalid_fields?

  scope :recent, ->{order created_at: :desc}

  def setup_write remain_ids, incorrect_ids, correct_ids
    @remain_words_ids = remain_ids
    @incorrect_words_ids = incorrect_ids
    @correct_words_ids = correct_ids
  end

  def new_word
    @current_word = Word.find_by id: remain_words_ids.sample
  end

  def current_word
    @current_word ||= new_word
  end

  def remain_words_ids
    @remain_words_ids ||= Array.new
  end

  private

  def invalid_fields? attributes
    word_attributes = attributes["word_attributes"]
    def_attributes = word_attributes["definitions_attributes"].values[0]
    word_attributes["text"].blank? || def_attributes["text"].blank?
  end
end
