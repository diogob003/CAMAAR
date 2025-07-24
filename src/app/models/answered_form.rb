# Classe responsável por armazenar as respostas de um formulário respondido por um usuário
class AnsweredForm < ApplicationRecord
  belongs_to :user
  belongs_to :form
  has_many :answers

  # Verifica se o usuário já respondeu o formulário.
  # @param user_id [int] ID do usuário
  # @param form_id [int] ID do formulário
  # @return [Boolean] true se já respondeu, false caso contrário
  def self.answered_by?(user_id, form_id)
    exists?(user_id: user_id, form_id: form_id)
  end
end
