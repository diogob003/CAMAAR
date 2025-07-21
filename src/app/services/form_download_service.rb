# Serviço para lidar com a geração de resultados de formulários (CSV)
class FormDownloadService
  def self.call(form_id)
    form = find_form(form_id)
    questions = ordered_questions(form)
    answered_forms = form.answered_forms.includes(:answers)
    csv_data = generate_csv(questions, answered_forms)
    { data: csv_data, filename: "form_#{form.id}_results.csv" }
  end

  def self.answer_value(answered_form, question)
    answer = find_answer(answered_form, question)
    question.options.any? ? answer&.option&.description : answer&.justification
  end

  private

  def self.find_form(form_id)
    Form.includes(:answered_forms, template: :questions).find(form_id)
  end

  def self.ordered_questions(form)
    form.template.questions.order(:order)
  end

  def self.find_answer(answered_form, question)
    answered_form.answers.find { |answer| answer.question_id == question.id }
  end

  def self.generate_csv(questions, answered_forms)
    rows = [questions.map(&:title)] +
           answered_forms.map { |af| csv_row(af, questions) }
    CSV.generate(headers: true) { |csv| write_rows(csv, rows) }
  end

  def self.write_rows(csv, rows)
    rows.each { |row| csv << row }
  end

  def self.csv_row(answered_form, questions)
    questions.map { |question| answer_value(answered_form, question) }
  end
end