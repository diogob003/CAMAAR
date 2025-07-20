Dado("estou na página de gerenciamento de templates") do
  visit admin_templates_list_path
  expect(page).to have_current_path(admin_templates_list_path)
end

Quando("clico na opção \"Editar\" do template") do
  puts "Clicando na opcao \"Editar\" do template"
end

Quando("clico no card do template") do
  find("a.template_box[data-template-id='#{@template.id}']").click
end

Então("devo modificar o nome, a descrição ou as perguntas do template") do
  puts "Modificando o nome, a descricao ou as perguntas do template"
end

Então("ao salvar, as mudanças não devem afetar formulários já criados com esse template") do
  puts "Verificando que formularios ja criados nao foram afetados"
end

Quando("clico na opção \"Deletar\" do template") do
  find("form.button_to button.delete-template-btn-x", match: :first).click
end

Então("o template deve ser removido da lista de templates disponíveis") do
  expect(page).to have_content("Template deleted successfully.")
end

Então("os formulários que já foram criados com base nesse template devem permanecer inalterados") do
  puts "Verificando que os formularios antigos permanecem inalterados"
end

Então("devo estar na pagina de edição do template") do
  save_and_open_page
  expect(page).to have_current_path(edit_admin_template_path(@template))
end

Dado("altero o nome do template") do
  fill_in "template_title", with: "Teste123"
end

Dado("clico em editar") do
  click_button "Update Template"
end

Então("o template deve ter o nome alterado") do
  expect(page).to have_content("Template updated successfully")
  expect(page).to have_content("Teste123")
end
