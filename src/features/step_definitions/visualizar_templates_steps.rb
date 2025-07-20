Então("devo ver uma grade com todos os templates criados") do
  expect(page).to have_css("a.template_box[data-template-id='#{@template.id}']")
end

Quando("clicar em deletar template") do
  find("form.button_to button.delete-template-btn-x", match: :first).click
end

Então("a tela deverá atualizar para não mostrar ele") do
  expect(page).to have_current_path(admin_templates_list_path)
  expect(page).to have_content("Template deleted successfully.")
  expect(page).to have_css("a.template_box", count: 1) # botao de '+' para adicionar mais
end
