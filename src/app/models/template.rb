class Template < ApplicationRecord
  belongs_to :usuario_criador, class_name: 'Usuario', foreign_key: :id_usuario_criador
  has_many :perguntas
end
