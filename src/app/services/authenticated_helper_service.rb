class AuthenticatedHelperService
  def self.fetch_class_group_ids(user)
    (class_student_ids(user) + class_professor_ids(user)).uniq
  end

  def self.fetch_forms(class_group_ids, query)
    query.present? ? forms_with_query(class_group_ids, query) : forms_without_query(class_group_ids)
  end

  def self.build_forms_data(forms, user)
    forms.map { |form| build_form_data(form, user) }.compact
  end

  private

  def self.class_student_ids(user)
    user.class_students.pluck(:class_group_id)
  end

  def self.class_professor_ids(user)
    user.class_professors.pluck(:class_group_id)
  end

  def self.forms_with_query(class_group_ids, query)
    Form.joins(class_forms: { class_group: :subject })
        .where(class_forms: { class_group_id: class_group_ids })
        .where("subjects.name LIKE ?", "%#{query}%")
        .distinct
  end

  def self.forms_without_query(class_group_ids)
    Form.joins(:class_forms)
        .where(class_forms: { class_group_id: class_group_ids })
        .distinct
  end

  def self.build_form_data(form, user)
    FormDataPresenter.new(form, user).as_json
  end

  def self.first_professor_name(class_group)
    class_group.class_professors.first&.professor&.name
  end

  def self.answered_form?(user, form_id)
    AnsweredForm.exists?(user_id: user.id, form_id: form_id)
  end
end