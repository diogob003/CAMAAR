Dado("tenho algum template criado") do
  puts "Template criado"
end

Dado("não possuo templates criados") do
  puts "Nenhum template criado"
end

Quando("escolho um template") do
  puts "Selecionando um template"
end

Quando("seleciono turmas ou docentes") do
  puts "Selecionando turmas ou docentes"
end

Então("na página de avaliações deve aparecer o formulário correspondente") do
  puts "Verificando que o formulário apareceu"
end

Então("o botão {string} está desabilitado") do |botao|
  puts "Verificando que o botão #{botao} está desabilitado"
end
