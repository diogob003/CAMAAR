class Template < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :forms
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
end
