# Classe utilizada para construir templates de questionários
# É um utilitário
class TemplateBuilder
  def self.build_question_if_empty(template)
    questions = template.questions
    questions.build if questions.none?
  end
end