# Classe simples para juntar parte da lógica de templates
class AdminTemplateEditService
  def initialize(template)
    @template = template
  end

  def prepare
    TemplateSorter.sort_questions_and_options(@template)
    TemplateBuilder.build_question_if_empty(@template)
  end
end
