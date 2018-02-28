class Word < ApplicationRecord
  has_many :definitions, dependent: :destroy

  validates :text, presence: true

  accepts_nested_attributes_for :definitions

  def correct_definition
    definitions.find_by correct: true
  end
end
