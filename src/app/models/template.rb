# É a entidade do sistema que coleciona as questoes e
# que pode ser usada para criar formulários
class Template < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :forms
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  # Retorna as questões ordenadas, cada uma com suas opções também ordenadas.
  # Sem parâmetros.
  # @return [Array<Question>] lista de questões ordenadas
  # Modifica o atributo options de cada questão (efeito colateral).
  def sorted_questions_with_options
    questions.order(:order).map do |question|
      question.options = question.options.order(:order)
      question
    end
  end
end
