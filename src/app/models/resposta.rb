class Resposta < ApplicationRecord
  belongs_to :pergunta
  belongs_to :opcao, optional: true
end
