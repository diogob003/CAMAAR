# É uma entidade do sistema para representar uma disciplina,
# e esta está associada a várias turmas
class Subject < ApplicationRecord
  has_many :class_groups
end
