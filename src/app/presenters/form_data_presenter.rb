# Classe usada apenas para agrupar as informações de um formulário
class FormDataPresenter

  # Inicializa o presenter com o formulário e o usuário.
  # @param form [Form] formulário a ser apresentado
  # @param user [User] usuário logado
  def initialize(form, user)
    @form = form
    @user = user
    @class_group = form.class_forms.first&.class_group
  end

  # Retorna os dados do formulário em formato de hash para exibição.
  # @return [Hash, nil] dados do formulário ou nil se não houver turma
  def as_json
    return unless @class_group
    form_id = @form.id
    {
      id: form_id,
      class_group_id: @class_group.id,
      subject: @class_group.subject&.name,
      semester: @class_group.semester,
      professor: @class_group.first_professor_name,
      answered: AnsweredForm.answered_by?(@user.id, form_id)
    }
  end
end
