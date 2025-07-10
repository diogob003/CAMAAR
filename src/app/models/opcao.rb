class Opcao < ApplicationRecord
  belongs_to :pergunta, foreign_key: :id_pergunta
end
