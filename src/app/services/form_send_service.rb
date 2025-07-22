# Serviço para lidar com a submissao de novos formulários
class FormSendService
  def self.call(params, user_id)
    return unauthorized_result unless user_id
    return already_exists_result if form_exists?(user_id, params)
    form, class_form = build_form_and_class_form(user_id, params)
    return success_result if form.save && class_form.save
    error_result
  end

  def self.unauthorized_result
    { path: "/new_form", alert: "Unauthorized" }
  end

  def self.form_exists?(user_id, params)
    Form.joins(:class_forms)
        .where(publisher_id: user_id, template_id: params[:template_id], class_forms: { class_group_id: params[:class_group_id] })
        .exists?
  end

  def self.already_exists_result
    { path: "/list_forms", alert: "Already exists an form for this class with the same template." }
  end

  def self.build_form_and_class_form(user_id, params)
    form = Form.new(publisher_id: user_id, template_id: params[:template_id])
    class_form = ClassForm.new(class_group_id: params[:class_group_id], form: form)
    [ form, class_form ]
  end

  def self.success_result
    { path: "/list_forms", notice: "Form created successfully." }
  end

  def self.error_result
    { path: "/new_form", alert: "Error creating form" }
  end
end
