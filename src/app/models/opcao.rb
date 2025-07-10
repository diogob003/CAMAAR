class Opcao < ApplicationRecord
  belongs_to :pergunta

  has_many :respostas
end
