class Pergunta < ApplicationRecord
  belongs_to :template

  has_many :opcoes
  has_many :respostas
end
