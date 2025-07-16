class Question < ApplicationRecord
  belongs_to :template
  has_many :options
  has_many :answers
  accepts_nested_attributes_for :options, allow_destroy: true
end
