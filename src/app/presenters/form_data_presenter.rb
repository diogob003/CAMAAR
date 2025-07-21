# Classe usada apenas para agrupar as informações de um formulário
class FormDataPresenter
  def initialize(form, user)
    @form = form
    @user = user
    @class_group = form.class_forms.first&.class_group
  end

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