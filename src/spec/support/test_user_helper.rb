module TestUserHelper
  def test_user
    User.find_or_create_by!(email: 'maria@gmail.com') do |user|
      user.name = 'Maria'
      user.password = 'maria1122'
      user.registration = 'M1122'
      user.role = 'professor'
    end
  end

  def test_class_group(user)
    subject = Subject.first || Subject.create!(name: 'Math', code: 'MATH101')
    class_group = ClassGroup.find_or_create_by!(number: 1, semester: '2025.1', subject_id: subject.id)
    ClassProfessor.find_or_create_by!(professor_id: user.id, class_group_id: class_group.id)
    class_group
  end

  def test_template(user)
    Template.find_or_create_by!(title: 'Template', description: 'Desc', creator_id: user.id)
  end

  def test_form(class_group, user, template = nil)
    template ||= test_template(user)
    form = Form.find_or_create_by!(open_date: Date.today, close_date: Date.today + 7, publisher_id: user.id, template_id: template.id)
    ClassForm.find_or_create_by!(class_group_id: class_group.id, form_id: form.id)
    form
  end

  def test_user_with_data
    user = test_user
    class_group = test_class_group(user)
    template = test_template(user)
    form = test_form(class_group, user, template)
    { user: user, class_group: class_group, template: template, form: form }
  end
end

RSpec.configure do |config|
  config.include TestUserHelper
end
