# Serviço para lidar com a logica da exclusao de formularios
class FormDestroyService
  def self.call(params)
    form = find_form(params)
    class_form = find_class_form(params)
    return cannot_delete_result if has_answers?(form)
    destroy_form_and_class_form(form, class_form)
    success_result
  end

  def self.find_form(params)
    Form.find(params[:id])
  end

  def self.find_class_form(params)
    ClassForm.find(params[:class_form_id])
  end

  def self.has_answers?(form)
    form.answered_forms.exists?
  end

  def self.cannot_delete_result
    { path: "/list_forms", alert: "Cannot delete: form has associated answers.", notice: nil }
  end

  def self.destroy_form_and_class_form(form, class_form)
    class_form.destroy
    form.destroy
  end

  def self.success_result
    { path: "/list_forms", alert: nil, notice: "Form deleted successfully." }
  end
end