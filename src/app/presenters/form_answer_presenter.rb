# Classe simples pra organizar os dados que
# serao apresentados
class FormAnswerPresenter
  def initialize(params)
    @params = params
  end

  def present
    form = find_form
    class_group, subject, template = form.first_class_group, form.subject, form.template
    questions = template.sorted_questions_with_options
    [ form, class_group, subject, template, questions ]
  end

  private

  def find_form
    Form.includes(class_forms: { class_group: :subject }).find_by(id: @params[:form_id])
  end
end
