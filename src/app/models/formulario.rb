class Formulario < ApplicationRecord
  belongs_to :usuario_publicador, class_name: 'Usuario'
  belongs_to :template

  has_many :turma_formularios
  has_many :turmas, through: :turma_formularios

  has_many :formularios_respondidos
  has_many :usuarios_que_responderam, through: :formularios_respondidos, source: :usuario
end
