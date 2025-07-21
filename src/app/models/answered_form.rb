# Classe responsável por armazenar as respostas de um formulário respondido por um usuário
class AnsweredForm < ApplicationRecord
  belongs_to :user
  belongs_to :form
  has_many :answers
end
