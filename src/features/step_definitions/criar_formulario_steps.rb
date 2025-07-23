Dado("que estou logado como administrador") do
  @user = FactoryBot.create(:user, registration: "U01", role: "professor")
  page.driver.post("/login?email_enrollment=#{@user.email}&password=#{@user.password}", user_id: @user.id)
end

Dado("estou na página de criação de formulários") do
  visit new_form_path
  expect(page).to have_current_path(new_form_path)
end

Dado("tenho templates de formulários disponíveis") do
  @template = FactoryBot.create(:template, creator: @user)
end

Dado("sou professor de uma turma") do
  @class_group = FactoryBot.create(:class_group)
  @class_professor = FactoryBot.create(:class_professor, class_group: @class_group, professor: @user)
end

Dado("escolhi um template no formulario") do
  select @template.title, from: "Template"
end

Dado("escolhi uma turma no formulario") do
  select @class_group.subject.name, from: "Turma"
end

Dado("ja existe um formulário com aquele template para aquela turma") do
  @form = FactoryBot.create(:form, template: @template, publisher: @user)
  @class_form = FactoryBot.create(:class_form, form: @form, class_group: @class_group)
end

Quando("clicar em \"Enviar\"") do
  click_button "Enviar"
end

Então("o formulário deve ser criado") do
  puts "Formulário disponível para as turmas selecionadas"
end

Então("deve aparecer uma mensagem de sucesso") do
  expect(page).to have_content("Form created successfully.")
end

Então("aparecer na página \"Avaliações\"") do
  visit authenticated_home_path
  form = Form.last
  expect(page).to have_css("a[data-form-id='#{form.id}']")
end

Então("uma mensagem de alerta deve aparecer indicando que a turma já possui aquele formulário") do
  expect(page).to have_content("Already exists an form for this class with the same template")
end
