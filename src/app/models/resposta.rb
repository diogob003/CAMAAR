class Resposta < ApplicationRecord
  belongs_to :pergunta, foreign_key: :id_pergunta
  belongs_to :opcao, foreign_key: :id_opcao, optional: true
end
