class TurmaProfessor < ApplicationRecord
  self.table_name = 'turma_professores'
  belongs_to :professor, class_name: 'Usuario'
  belongs_to :turma
end
