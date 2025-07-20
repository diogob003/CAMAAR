Dado("que existe um aluno cadastrado") do
  @user = FactoryBot.create(:user, email: "teste_123@gmail.com", registration: "teste123", password: "senha123", role: "aluno")
end

Dado("que existe um administrador cadastrado") do
  @user = FactoryBot.create(:user, email: "adm@gmail.com", registration: "ADM", password: "admin", role: "professor")
end

Dado("que estou na página de login") do
  visit login_path
  expect(page).to have_current_path(login_path)
end

Dado("preenchi com email e senha válidos") do
  fill_in "Email ou matrícula", with: "teste_123@gmail.com"
  fill_in "Senha", with: "senha123"
end

Dado("preenchi com matrícula e senha válidos") do
  fill_in "Email ou matrícula", with: "teste123"
  fill_in "Senha", with: "senha123"
end

Dado("preenchi um e-mail, matrícula ou senha incorretos") do
  fill_in "Email ou matrícula", with: "email_invalido@gmail.com"
  fill_in "Senha", with: "senha123345"
end

Quando("clico em \"Entrar\"") do
  click_button "Entrar"
end

Quando("coloco as credenciais de administrador") do
  fill_in "Email ou matrícula", with: "adm@gmail.com"
  fill_in "Senha", with: "admin"
end

Então("devo ser redirecionado para a página inicial") do
  expect(page).to have_current_path(authenticated_home_path)
end

Então("ver um aviso de sucesso de login") do
  expect(page).to have_content("Logged in!")
end

Então("devo ver a opção de gerenciamento no menu lateral") do
  expect(page).to have_link("Gerenciamento", href: authenticated_admin_path)
end

Então("nao ter acesso ao menu de gerenciamento") do
  expect(page).not_to have_link("Gerenciamento", href: authenticated_admin_path)
end

Então("devo ver uma mensagem de credenciais inválidas") do
  expect(page).to have_content("Senha ou email inválido")
end
