# Serviço para lidar com a logica da exclusao de formularios
class FormDestroyService
  # Exclui um formulário e seu class_form se não houver respostas.
  # @param params [Hash] parâmetros com :id e :class_form_id
  # @return [Hash] resultado com caminho de redirecionamento, alerta e aviso
  # Efeito colateral: Remove registros do banco de dados.
  def self.call(params)
    form = find_form(params)
    class_form = find_class_form(params)
    return cannot_delete_result if has_answers?(form)
    destroy_form_and_class_form(form, class_form)
    success_result
  end

  # Busca o formulário pelo id.
  # @param params [Hash]
  # @return [Form]
  def self.find_form(params)
    Form.find(params[:id])
  end

  # Busca o class_form pelo id.
  # @param params [Hash]
  # @return [ClassForm]
  def self.find_class_form(params)
    ClassForm.find(params[:class_form_id])
  end

  # Verifica se o formulário possui respostas.
  # @param form [Form]
  # @return [Boolean]
  def self.has_answers?(form)
    form.answered_forms.exists?
  end

  # Retorna resultado quando não pode excluir.
  # @return [Hash]
  def self.cannot_delete_result
    { path: "/list_forms", alert: "Cannot delete: form has associated answers.", notice: nil }
  end

  # Exclui o formulário e o class_form.
  # @param form [Form]
  # @param class_form [ClassForm]
  # Efeito colateral: Remove registros do banco de dados.
  def self.destroy_form_and_class_form(form, class_form)
    class_form.destroy
    form.destroy
  end

  # Retorna resultado de sucesso na exclusão.
  # @return [Hash]
  def self.success_result
    { path: "/list_forms", alert: nil, notice: "Form deleted successfully." }
  end
end
