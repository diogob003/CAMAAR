class Template < ApplicationRecord
  belongs_to :usuario_criador, class_name: 'Usuario'
  has_many :perguntas
end
