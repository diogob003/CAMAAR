Dado("estou na página \"Gerenciamento\"") do
  visit authenticated_admin_path
  expect(page).to have_current_path(authenticated_admin_path)
end

Dado("eu criei um formulario para uma de minhas turmas") do
  @class_group = FactoryBot.create(:class_group)

  template = FactoryBot.create(:template, creator: @user)
  FactoryBot.create(:question, template: template)
  @form = FactoryBot.create(:form, publisher: @user, template: template)
  ClassForm.create!(class_group: @class_group, form: @form)
end

Dado("nao criei nenhum formulario") do
  # é só nao criar um formulário,
  # ou seja, nesse caso basta nao fazer nada
end

Quando("clicar em \"Resultados\"") do
  find("#resultadosBtn").click
end

Quando("estiver na página de resultados") do
  expect(page).to have_current_path(form_results_path)
end

Então("devo ver uma grade com o formulário disponível") do
  expect(page).to have_css("a.template_box")
  expect(page).to have_content(@form.class_groups.first.subject.name)
  expect(page).to have_content(@form.class_groups.first.subject.code)
  expect(page).to have_content(@form.class_groups.first.semester)
end

Entao("a grade de resultados deve estar vazia") do
  expect(page).to have_css("a.template_box", count: 0)
end
