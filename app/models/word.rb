class Word < ApplicationRecord
  has_many :definitions, dependent: :destroy
end
