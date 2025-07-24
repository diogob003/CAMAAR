# Responsavel por ordenar as questoes (e as opcoes) de um dado template
class TemplateSorter
  def self.sort_questions_and_options(template)
    questions = template.questions.sort_by(&:order)
    questions.each do |question|
      question.options = question.options.sort_by(&:order)
    end
    template.questions = questions
  end
end
