# Entidade do sistema responsavel por representar uma
# opcao de resposta para uma questao
class Option < ApplicationRecord
  belongs_to :question
  has_many :answers
end
