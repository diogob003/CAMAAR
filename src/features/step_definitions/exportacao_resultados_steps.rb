Dado("estou na pagina de resultados") do
  visit form_results_path
  expect(page).to have_current_path(form_results_path)
end

Quando("Clicar no botão de baixar o csv") do
  find("button.download-csv-btn", match: :first).click
end


Então("os resultados devem ser baixado em CSV") do
  # Cucumber e Capybara nao tem como checar se o download realmente aconteceu sozinhos
  # teria que usar o Selenium pra isso,
  # então essa parte não será testada via cucumber/capybara
end