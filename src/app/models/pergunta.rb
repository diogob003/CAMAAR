class Pergunta < ApplicationRecord
  belongs_to :template, foreign_key: :id_template
  has_many :opcoes
end
