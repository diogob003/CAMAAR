class Pergunta < ApplicationRecord
  belongs_to :template

  has_many :opcoes, class_name: "Opcao"
  has_many :respostas
end
