class ClassProfessor < ApplicationRecord
  belongs_to :professor, class_name: "User"
  belongs_to :class_group
end
