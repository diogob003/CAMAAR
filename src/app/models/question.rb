class Question < ApplicationRecord
  belongs_to :template
  has_many :options
  has_many :answers
end
