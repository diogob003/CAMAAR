# Entidade responsavel por relacionar um professor a uma turma
class ClassProfessor < ApplicationRecord
  belongs_to :professor, class_name: "User"
  belongs_to :class_group
end
