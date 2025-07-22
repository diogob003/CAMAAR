require 'rails_helper'
require 'csv'

RSpec.describe FormDownloadService, type: :service do
  let(:user) { test_user }
  let(:class_group) { test_class_group(user) }
  let(:template) { test_template(user) }
  let(:form) { test_form(class_group, user, template) }

  let!(:option_question) do
    Question.create!(
      title: 'Option Q',
      description: 'desc',
      template: template,
      order: 1,
      answer_type: 'option'
    )
  end

  let!(:option) do
    Option.create!(
      description: 'Option 1',
      order: 1,
      question: option_question
    )
  end

  let!(:text_question) do
    Question.create!(
      title: 'Text Q',
      description: 'desc',
      template: template,
      order: 2,
      answer_type: 'text'
    )
  end

  let!(:answered_form) do
    AnsweredForm.create!(user: user, form: form)
  end

  let!(:option_answer) do
    Answer.create!(
      answered_form: answered_form,
      question: option_question,
      option: option
    )
  end

  let!(:text_answer) do
    Answer.create!(
      answered_form: answered_form,
      question: text_question,
      justification: 'Justification text'
    )
  end

  describe '.call' do
    it 'returns CSV data and filename for the form' do
      result = described_class.call(form.id)
      expect(result).to be_a(Hash)
      expect(result[:filename]).to eq("form_#{form.id}_results.csv")
      csv = CSV.parse(result[:data], headers: true)
      expect(csv.headers).to eq([ option_question.title, text_question.title ])
      expect(csv[0][option_question.title]).to eq(option.description)
      expect(csv[0][text_question.title]).to eq('Justification text')
    end
  end

  describe '.answer_value' do
    context 'for option question' do
      it 'returns option description' do
        value = described_class.answer_value(answered_form, option_question)
        expect(value).to eq(option.description)
      end
    end

    context 'for text question' do
      it 'returns justification' do
        value = described_class.answer_value(answered_form, text_question)
        expect(value).to eq('Justification text')
      end
    end

    context 'when no answer exists' do
      let(:other_question) do
        Question.create!(
          title: 'Other Q',
          description: 'desc',
          template: template,
          order: 3,
          answer_type: 'text'
        )
      end

      it 'returns nil' do
        value = described_class.answer_value(answered_form, other_question)
        expect(value).to be_nil
      end
    end
  end

  describe '.find_form' do
    it 'finds the form with associations' do
      found = described_class.send(:find_form, form.id)
      expect(found).to eq(form)
      expect(found.answered_forms).to include(answered_form)
      expect(found.template.questions).to include(option_question, text_question)
    end
  end

  describe '.ordered_questions' do
    it 'returns questions ordered by order' do
      ordered = described_class.send(:ordered_questions, form)
      expect(ordered.map(&:id)).to eq([ option_question.id, text_question.id ])
    end
  end

  describe '.find_answer' do
    it 'finds the correct answer for a question' do
      answer = described_class.send(:find_answer, answered_form, option_question)
      expect(answer).to eq(option_answer)
    end

    it 'returns nil if no answer exists' do
      other_question = Question.create!(title: 'Other', description: '', template: template, order: 3, answer_type: 'text')
      answer = described_class.send(:find_answer, answered_form, other_question)
      expect(answer).to be_nil
    end
  end

  describe '.generate_csv' do
    it 'generates CSV with headers and rows' do
      questions = [ option_question, text_question ]
      answered_forms = [ answered_form ]
      csv = described_class.send(:generate_csv, questions, answered_forms)
      parsed = CSV.parse(csv, headers: true)
      expect(parsed.headers).to eq([ option_question.title, text_question.title ])
      expect(parsed[0][option_question.title]).to eq(option.description)
      expect(parsed[0][text_question.title]).to eq('Justification text')
    end
  end

  describe '.write_rows' do
    it 'writes rows to CSV object' do
      rows = [ [ 'Header1', 'Header2' ], [ 'A', 'B' ] ]
      csv_str = CSV.generate(headers: true) do |csv|
        described_class.send(:write_rows, csv, rows)
      end
      parsed = CSV.parse(csv_str, headers: true)
      expect(parsed.headers).to eq([ 'Header1', 'Header2' ])
      expect(parsed[0]['Header1']).to eq('A')
      expect(parsed[0]['Header2']).to eq('B')
    end
  end

  describe '.csv_row' do
    it 'returns array of answer values for questions' do
      row = described_class.send(:csv_row, answered_form, [ option_question, text_question ])
      expect(row).to eq([ option.description, 'Justification text' ])
    end
  end
end
