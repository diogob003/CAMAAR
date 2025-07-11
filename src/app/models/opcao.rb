class Opcao < ApplicationRecord
  self.table_name = 'opcoes'

  belongs_to :pergunta

  has_many :respostas
end
