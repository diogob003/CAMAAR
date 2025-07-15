Dado("existe um formulario para uma de minhas turmas") do
  @class_group = FactoryBot.create(:class_group)
  @class_group.students << @user

  publisher = FactoryBot.create(:user, email: "publisher@example.com", registration: "P01", role: "professor")
  creator = FactoryBot.create(:user, email: "creator@example.com", registration: "C01", role: "professor")
  template = FactoryBot.create(:template, creator: creator)
  FactoryBot.create(:question, template: template)
  @form = FactoryBot.create(:form, publisher: publisher, template: template)
  ClassForm.create!(class_group: @class_group, form: @form)
end

Quando("clico nesse formulário") do
  expect(page).to have_css("a.formulario_box")
  find("a.formulario_box").click
end

Quando("vou para a página de submissao de respostas do formulário") do
  expect(page).to have_current_path("/answer_form/?form_id=#{@form.id}&class_group_id=#{@class_group.id}")
end

Quando("volto para página de \"Avaliações\"") do
  visit authenticated_home_path
end

Quando("respondo a pergunta com o texto \"Gostei da disciplina\"") do
  within(".text-input-group") do
    fill_in placeholder: "Type your answer", with: "Gostei da disciplina"
  end
end

Quando("faço a submissao") do
  find("button.send-button[type=\"submit\"]").click
end

Então("devo ser redirecionado para a página de submissao de respostas do formulário") do
  expect(page).to have_current_path("/answer_form/?form_id=#{@form.id}&class_group_id=#{@class_group.id}")
end

Então("o formulário deve continuar como não respondido") do
  expect(page).to have_css("a.formulario_box")

  all("a.formulario_box").each do |div|
    expect(div).to have_css("p.status", text: "Pendente")
  end
end
