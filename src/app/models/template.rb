class Template < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :forms
  has_many :questions
end
