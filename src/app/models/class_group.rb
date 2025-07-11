class ClassGroup < ApplicationRecord
  belongs_to :subject

  has_many :class_professors
  has_many :professors, through: :class_professors, source: :professor

  has_many :class_students
  has_many :students, through: :class_students, source: :student

  has_many :class_forms
  has_many :forms, through: :class_forms
end
