class TemplateBuilder
  def self.build_question_if_empty(template)
    template.questions.build if template.questions.none?
  end
end