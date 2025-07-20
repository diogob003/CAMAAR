Dado("que estou logado como estudante") do
  @user = FactoryBot.create(:user, registration: "U01")
  page.driver.post("/login?email_enrollment=#{@user.email}&password=#{@user.password}", user_id: @user.id)
end

Dado("estou matriculado em uma turma") do
  @class_group = FactoryBot.create(:class_group)
  @class_group.students << @user
  puts "DEBUG: Usuario #{@user.id} (#{@user.role}) matriculado na turma #{@class_group.id} com nome #{@class_group.subject&.name.inspect}"
end

Dado("existe um formulário de avaliação para essa turma") do
  publisher = FactoryBot.create(:user, email: "publisher@example.com", registration: "P01", role: "professor")
  creator = FactoryBot.create(:user, email: "creator@example.com", registration: "C01", role: "professor")
  template = FactoryBot.create(:template, creator: creator)
  @form = FactoryBot.create(:form, publisher: publisher, template: template)
  ClassForm.create!(class_group: @class_group, form: @form)
end

Dado("eu já respondi esse formulário") do
  FactoryBot.create(:answered_form, user: @user, form: @form)
end

Quando("acesso a página \"Avaliações\"") do
  visit authenticated_home_path
end

Então("devo ver uma grade com todos os formulários") do
  expect(page).to have_css("div#formularioBoxesContainer")
end

Então("cada formulário deve mostrar o nome da disciplina, semestre e nome do professor") do
  expect(page).to have_css("a.template_box")

  all("a.template_box").each do |a|
    expect(a).to have_css("h3.subject")
    expect(a).to have_css("p.semester")
    expect(a).to have_css("p.professor-name")
  end
end


Então("o formulário está marcado como respondido") do
  expect(page).to have_css("a.template_box")

  all("a.template_box").each do |div|
    expect(div).to have_css("p.status", text: "Respondido")
  end
end
