# Serviço para lidar com a submissao de formulários
class FormSubmitService
  def self.call(params, user_id)
    return unauthorized unless user_id
    user = find_user(user_id)
    form = find_form(params[:form_id])
    create_answers(form, create_answered_form(user, form), params[:answers])
    success
  end

  private

  def self.unauthorized
    { type: :alert, message: "Unauthorized" }
  end

  def self.success
    { type: :notice, message: "Formulário enviado com sucesso!" }
  end

  def self.find_user(user_id)
    User.find(user_id)
  end

  def self.find_form(form_id)
    Form.find_by(id: form_id)
  end

  def self.create_answered_form(user, form)
    AnsweredForm.create!(user: user, form: form)
  end

  def self.create_answers(form, answered_form, answers)
    form.template.questions.each { |question| create_answer(question, answered_form, answers) }
  end

  def self.create_answer(question, answered_form, answers)
    value = answers[question.id.to_s]
    has_options = question.options.any?
    Answer.create!(
      answered_form: answered_form,
      question: question,
      option_id: has_options ? value : nil,
      justification: has_options ? nil : value
    )
  end
end
