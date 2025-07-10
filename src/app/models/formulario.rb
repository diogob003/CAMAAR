class Formulario < ApplicationRecord
  belongs_to :usuario_publicador, class_name: 'Usuario', foreign_key: :id_usuario_publicador
  belongs_to :template, foreign_key: :id_template

  has_many :turma_formularios
  has_many :turmas, through: :turma_formularios

  has_many :formularios_respondidos
end
