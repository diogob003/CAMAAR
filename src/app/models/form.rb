class Form < ApplicationRecord
  belongs_to :publisher, class_name: "User"
  belongs_to :template

  has_many :class_forms
  has_many :class_groups, through: :class_forms

  has_many :answered_forms
end
