class Answer < ApplicationRecord
  belongs_to :answered_form
  belongs_to :question
  belongs_to :option, optional: true
end
