# Classe simples pra organizar os dados que
# serao apresentados
class FormAnswerPresenter
  # Inicializa o presenter com os parâmetros recebidos.
  # @param params [Hash] parâmetros da requisição, incluindo :form_id
  def initialize(params)
    @params = params
  end

  # Retorna os dados do formulário para exibição.
  # @return [Array] [formulário, turma, disciplina, template, perguntas]
  def present
    form = find_form
    class_group, subject, template = form.first_class_group, form.subject, form.template
    questions = template.sorted_questions_with_options
    [ form, class_group, subject, template, questions ]
  end

  private

  # Busca o formulário pelo ID informado nos parâmetros.
  # @return [Form, nil] formulário encontrado ou nil
  def find_form
    Form.includes(class_forms: { class_group: :subject }).find_by(id: @params[:form_id])
  end
end
