require 'rails_helper'

RSpec.describe FormSubmitService, type: :service do
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

  describe '.call' do
    context 'when user_id is nil' do
      it 'returns unauthorized result' do
        result = described_class.call({ form_id: form.id, answers: {} }, nil)
        expect(result).to eq(type: :alert, message: 'Unauthorized')
      end
    end

    context 'when user_id is present' do
      let(:answers) do
        {
          option_question.id.to_s => option.id,
          text_question.id.to_s => 'Justification text'
        }
      end

      it 'creates answered_form and answers, returns success' do
        expect {
          result = described_class.call({ form_id: form.id, answers: answers }, user.id)
          expect(result).to eq(type: :notice, message: 'Formulário enviado com sucesso!')
        }.to change(AnsweredForm, :count).by(1).and change(Answer, :count).by(2)

        answered_form = AnsweredForm.last
        answer1 = Answer.find_by(answered_form: answered_form, question: option_question)
        answer2 = Answer.find_by(answered_form: answered_form, question: text_question)

        expect(answer1.option_id).to eq(option.id)
        expect(answer1.justification).to be_nil
        expect(answer2.option_id).to be_nil
        expect(answer2.justification).to eq('Justification text')
      end

      it 'finds user and form correctly' do
        expect(User).to receive(:find).with(user.id).and_call_original
        expect(Form).to receive(:find_by).with(id: form.id).and_call_original
        described_class.call({ form_id: form.id, answers: answers }, user.id)
      end

      it 'creates answers for all questions in template' do
        described_class.call({ form_id: form.id, answers: answers }, user.id)
        expect(Answer.where(answered_form_id: AnsweredForm.last.id).count).to eq(template.questions.count)
      end
    end
  end

  describe '.unauthorized' do
    it 'returns alert hash' do
      expect(described_class.send(:unauthorized)).to eq(type: :alert, message: 'Unauthorized')
    end
  end

  describe '.success' do
    it 'returns notice hash' do
      expect(described_class.send(:success)).to eq(type: :notice, message: 'Formulário enviado com sucesso!')
    end
  end

  describe '.find_user' do
    it 'returns the user' do
      expect(described_class.send(:find_user, user.id)).to eq(user)
    end
  end

  describe '.find_form' do
    it 'returns the form' do
      expect(described_class.send(:find_form, form.id)).to eq(form)
    end
  end

  describe '.create_answered_form' do
    it 'creates an AnsweredForm record' do
      expect {
        described_class.send(:create_answered_form, user, form)
      }.to change(AnsweredForm, :count).by(1)
    end
  end

  describe '.create_answers' do
    it 'creates answers for each question' do
      answered_form = described_class.send(:create_answered_form, user, form)
      answers = {
        option_question.id.to_s => option.id,
        text_question.id.to_s => 'Justification text'
      }
      expect {
        described_class.send(:create_answers, form, answered_form, answers)
      }.to change(Answer, :count).by(2)
    end
  end

  describe '.create_answer' do
    let(:answered_form) { described_class.send(:create_answered_form, user, form) }

    it 'creates answer with option for option question' do
      answers = { option_question.id.to_s => option.id }
      expect {
        described_class.send(:create_answer, option_question, answered_form, answers)
      }.to change(Answer, :count).by(1)
      answer = Answer.last
      expect(answer.option_id).to eq(option.id)
      expect(answer.justification).to be_nil
    end

    it 'creates answer with justification for text question' do
      answers = { text_question.id.to_s => 'Justification text' }
      expect {
        described_class.send(:create_answer, text_question, answered_form, answers)
      }.to change(Answer, :count).by(1)
      answer = Answer.last
      expect(answer.option_id).to be_nil
      expect(answer.justification).to eq('Justification text')
    end
  end
end
