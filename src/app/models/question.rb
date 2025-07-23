class Question < ApplicationRecord
  belongs_to :template
  has_many :options, dependent: :destroy
  has_many :answers
  accepts_nested_attributes_for :options, allow_destroy: true
end
