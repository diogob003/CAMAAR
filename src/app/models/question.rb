# Entidade do sistema responsavel por representar uma questao
# é usada principalmente em templates e pode conter opcoes
class Question < ApplicationRecord
  belongs_to :template
  has_many :options, dependent: :destroy
  has_many :answers
  accepts_nested_attributes_for :options, allow_destroy: true
end
