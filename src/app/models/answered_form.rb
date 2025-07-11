class AnsweredForm < ApplicationRecord
  belongs_to :user
  belongs_to :form
end
