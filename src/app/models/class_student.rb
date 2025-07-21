# Entidade responsável por representar a associação entre um aluno e uma turma
class ClassStudent < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :class_group
end
