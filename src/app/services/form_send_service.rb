# Serviço para lidar com a submissao de novos formulários
class FormSendService
  # Envia um novo formulário.
  # @param params [Hash] parâmetros do formulário
  # @param user_id [Integer] id do usuário
  # @return [Hash] resultado com caminho de redirecionamento, alerta ou aviso
  # Efeito colateral: Cria registros no banco de dados. Redireciona para outra página.
  def self.call(params, user_id)
    return unauthorized_result unless user_id
    return already_exists_result if form_exists?(user_id, params)
    form, class_form = build_form_and_class_form(user_id, params)
    return success_result if form.save && class_form.save
    error_result
  end

  # Retorna resultado de usuário não autorizado.
  # @return [Hash] contém caminho e alerta
  # Redireciona para página de novo formulário.
  def self.unauthorized_result
    { path: "/new_form", alert: "Unauthorized" }
  end

  # Verifica se já existe formulário igual (mesma turma e mesmo template)
  # @param user_id [Integer]
  # @param params [Hash] (template_id, class_group_id)
  # @return [Boolean]
  def self.form_exists?(user_id, params)
    Form.joins(:class_forms)
        .where(publisher_id: user_id, template_id: params[:template_id], class_forms: { class_group_id: params[:class_group_id] })
        .exists?
  end

  # Retorna resultado de formulário já existente.
  # @return [Hash] contém caminho e alerta
  # Redireciona para lista de formulários.
  def self.already_exists_result
    { path: "/list_forms", alert: "Already exists an form for this class with the same template." }
  end

  # Retorna resultado de formulário já existente.
  # @return [Hash] contém caminho e alerta
  # Redireciona para lista de formulários.
  def self.build_form_and_class_form(user_id, params)
    form = Form.new(publisher_id: user_id, template_id: params[:template_id])
    class_form = ClassForm.new(class_group_id: params[:class_group_id], form: form)
    [ form, class_form ]
  end

  # Retorna resultado de sucesso.
  # @return [Hash] contém caminho e aviso
  # Redireciona para lista de formulários.
  def self.success_result
    { path: "/list_forms", notice: "Form created successfully." }
  end

  # Retorna resultado de erro.
  # @return [Hash] contém caminho e alerta
  # Redireciona para página de novo formulário.
  def self.error_result
    { path: "/new_form", alert: "Error creating form" }
  end
end
