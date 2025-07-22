# Serviço para lidar com a submissao de formulários
class FormSubmitService

  # Submete respostas de um formulário.
  # @param params [Hash] parâmetros do formulário e respostas
  # @param user_id [Integer] id do usuário
  # @return [Hash] resultado com tipo (:alert ou :notice) e mensagem
  # Efeito colateral: Cria registros de respostas no banco de dados.
  def self.call(params, user_id)
    return unauthorized unless user_id
    user = find_user(user_id)
    form = find_form(params[:form_id])
    create_answers(form, create_answered_form(user, form), params[:answers])
    success
  end

  private

  # Retorna resultado de usuário não autorizado.
  # @return [Hash] tipo :alert e mensagem
  def self.unauthorized
    { type: :alert, message: "Unauthorized" }
  end

  # Retorna resultado de sucesso.
  # @return [Hash] tipo :notice e mensagem
  def self.success
    { type: :notice, message: "Formulário enviado com sucesso!" }
  end

  # Busca o usuário pelo id.
  # @param user_id [Integer]
  # @return [User]
  def self.find_user(user_id)
    User.find(user_id)
  end

  # Busca o formulário pelo id.
  # @param form_id [Integer]
  # @return [Form]
  def self.find_form(form_id)
    Form.find_by(id: form_id)
  end

  # Cria registro de formulário respondido.
  # @param user [User]
  # @param form [Form]
  # @return [AnsweredForm]
  # Efeito colateral: Cria registro no banco de dados.
  def self.create_answered_form(user, form)
    AnsweredForm.create!(user: user, form: form)
  end

  # Cria respostas para o formulário.
  # @param form [Form]
  # @param answered_form [AnsweredForm]
  # @param answers [Hash] respostas
  def self.create_answers(form, answered_form, answers)
    form.template.questions.each { |question| create_answer(question, answered_form, answers) }
  end

  # Cria uma resposta para uma questão.
  # @param question [Question]
  # @param answered_form [AnsweredForm]
  # @param answers [Hash]
  # Efeito colateral: Cria registro de resposta no banco de dados.
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
