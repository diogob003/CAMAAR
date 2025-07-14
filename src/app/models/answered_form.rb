class AnsweredForm < ApplicationRecord
  belongs_to :user
  belongs_to :form
  has_many :answers
end
