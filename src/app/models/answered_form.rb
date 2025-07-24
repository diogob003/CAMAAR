# Classe responsável por armazenar as respostas de um formulário respondido por um usuário
class AnsweredForm < ApplicationRecord
  belongs_to :user
  belongs_to :form
  has_many :answers

  def self.answered_by?(user_id, form_id)
    exists?(user_id: user_id, form_id: form_id)
  end
end
