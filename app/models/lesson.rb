class Lesson < ApplicationRecord
  attr_reader :correct_words_ids, :incorrect_words_ids, :is_correct

  belongs_to :user
  belongs_to :bookmarker, optional: true,
    inverse_of: :bookmarked_lessons, class_name: User.name

  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words

  accepts_nested_attributes_for :lesson_words, allow_destroy: true,
    reject_if: :invalid_fields?

  scope :recent, ->{order created_at: :desc}

  def setup_write remain_ids, incorrect_ids, correct_ids, is_correct
    lesson_info[:remains] = remain_ids
    lesson_info[:incorrects] = incorrect_ids
    lesson_info[:corrects] = correct_ids
    lesson_info[:is_correct] = is_correct
  end

  def lesson_info
    @lesson_info ||= Hash.new
  end

  def new_word
    @current_word = Word.find_by id: lesson_info[:remains].sample
  end

  def current_word
    @current_word ||= new_word
  end

  private

  def invalid_fields? attributes
    word_attributes = attributes["word_attributes"]
    def_attributes = word_attributes["definitions_attributes"].values[0]
    word_attributes["text"].blank? || def_attributes["text"].blank?
  end
end
