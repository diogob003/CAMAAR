class TurmaProfessor < ApplicationRecord
  belongs_to :professor, class_name: 'Usuario'
  belongs_to :turma
end
