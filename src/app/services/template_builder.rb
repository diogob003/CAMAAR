# Classe utilizada para construir templates de questionários
# É um utilitário
class TemplateBuilder

  # Adiciona uma questão ao template se não houver nenhuma.
  # @param template [Template] template do questionário
  # Efeito colateral: Cria uma nova questão associada ao template.
  def self.build_question_if_empty(template)
    questions = template.questions
    questions.build if questions.none?
  end
end
