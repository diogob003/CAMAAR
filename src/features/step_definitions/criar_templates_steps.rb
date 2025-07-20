# frozen_string_literal: true
#
Dado("estou na página \"Gerenciamento\" de templates") do
  visit admin_templates_list_path
  expect(page).to have_current_path(admin_templates_list_path)
end

Dado("cliquei em \"+\" para criar template") do
  find('a.template_box[href="' + new_admin_template_path + '"]').click
end

Dado("fui para a página de criação de template") do
  expect(page).to have_current_path(new_admin_template_path)
end

Dado("adicionei uma nova questão") do
  fill_in "Template Name", with: "titulo teste"
  fill_in "Description", with: "descricao teste"
  fill_in "Question Name", with: "questao teste"
end

Quando("clicar em \"Criar\"") do
  click_button "Create Template"
end

Então("o template será criado com sucesso") do
  expect(page).to have_content("Template created successfully.")
  expect(page).to have_current_path(admin_templates_list_path)
  expect(page).to have_content("titulo teste")
end

Então("deverá aparecer uma mensagem de erro") do
  expect(page).to have_content("Template name can't be blank.")
end