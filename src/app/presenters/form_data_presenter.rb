class FormDataPresenter
  def initialize(form, user)
    @form = form
    @user = user
  end

  def as_json
    class_group = @form.class_forms.first&.class_group
    return unless class_group

    {
      id: @form.id,
      class_group_id: class_group.id,
      subject: class_group.subject&.name,
      semester: class_group.semester,
      professor: first_professor_name(class_group),
      answered: answered_form?(@user, @form.id)
    }
  end

  private

  def first_professor_name(class_group)
    class_group.class_professors.first&.professor&.name
  end

  def answered_form?(user, form_id)
    AnsweredForm.exists?(user_id: user.id, form_id: form_id)
  end
end