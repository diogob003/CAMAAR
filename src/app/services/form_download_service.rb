# Serviço para lidar com a geração de resultados de formulários (CSV)
class FormDownloadService

  # Gera o CSV dos resultados do formulário.
  # @param form_id [Integer] id do formulário
  # @return [Hash] contém :data (CSV) e :filename
  def self.call(form_id)
    form = find_form(form_id)
    questions = ordered_questions(form)
    answered_forms = form.answered_forms.includes(:answers)
    csv_data = generate_csv(questions, answered_forms)
    { data: csv_data, filename: "form_#{form.id}_results.csv" }
  end

  # Retorna o valor da resposta para uma questão.
  # @param answered_form [AnsweredForm] formulário respondido
  # @param question [Question] questão
  # @return [String, nil] valor da resposta
  def self.answer_value(answered_form, question)
    answer = find_answer(answered_form, question)
    question.options.any? ? answer&.option&.description : answer&.justification
  end

  private

  # Busca o formulário pelo id.
  # @param form_id [Integer]
  # @return [Form]
  def self.find_form(form_id)
    Form.includes(:answered_forms, template: :questions).find(form_id)
  end

  # Retorna as questões ordenadas do formulário.
  # @param form [Form]
  # @return [ActiveRecord::Relation] questões
  def self.ordered_questions(form)
    form.template.questions.order(:order)
  end

  # Busca a resposta de uma questão.
  # @param answered_form [AnsweredForm]
  # @param question [Question]
  # @return [Answer, nil]
  def self.find_answer(answered_form, question)
    answered_form.answers.find { |answer| answer.question_id == question.id }
  end

  # Gera o conteúdo CSV.
  # @param questions [Array<Question>]
  # @param answered_forms [Array<AnsweredForm>]
  # @return [String] CSV
  def self.generate_csv(questions, answered_forms)
    rows = [ questions.map(&:title) ] +
           answered_forms.map { |af| csv_row(af, questions) }
    CSV.generate(headers: true) { |csv| write_rows(csv, rows) }
  end

  # Escreve as linhas no CSV.
  # @param csv [CSV]
  # @param rows [Array<Array<String>>]
  def self.write_rows(csv, rows)
    rows.each { |row| csv << row }
  end

  # Monta uma linha do CSV para um formulário respondido.
  # @param answered_form [AnsweredForm]
  # @param questions [Array<Question>]
  # @return [Array<String>]
  def self.csv_row(answered_form, questions)
    questions.map { |question| answer_value(answered_form, question) }
  end
end
