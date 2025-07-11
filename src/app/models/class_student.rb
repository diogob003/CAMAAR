class ClassStudent < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :class_group
end
