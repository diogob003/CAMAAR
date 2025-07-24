require 'rails_helper'

RSpec.describe FormAnswerPresenter do
  let(:user) { test_user }
  let(:class_group) { test_class_group(user) }
  let(:subject) { class_group.subject }
  let(:template) { test_template(user) }
  let(:form) { test_form(class_group, user, template) }

  let!(:question1) do
    Question.create!(
      title: 'Q1',
      description: 'desc1',
      template: template,
      order: 1,
      answer_type: 'option'
    )
  end

  let!(:option1) do
    Option.create!(
      description: 'Option 1',
      order: 1,
      question: question1
    )
  end

  let!(:question2) do
    Question.create!(
      title: 'Q2',
      description: 'desc2',
      template: template,
      order: 2,
      answer_type: 'text'
    )
  end

  let(:params) { { form_id: form.id } }
  let(:presenter) { described_class.new(params) }

  describe '#initialize' do
    it 'sets @params' do
      expect(presenter.instance_variable_get(:@params)).to eq(params)
    end
  end

  describe '#present' do
    it 'returns form, class_group, subject, template, questions' do
      result = presenter.present
      expect(result[0]).to eq(form)
      expect(result[1]).to eq(class_group)
      expect(result[2]).to eq(subject)
      expect(result[3]).to eq(template)
      expect(result[4]).to be_an(Array)
      expect(result[4].map(&:id)).to include(question1.id, question2.id)
    end

    it 'returns questions sorted with options' do
      questions = presenter.present[4]
      expect(questions.first).to eq(question1)
      expect(questions.first.options).to include(option1)
    end
  end

  describe '#find_form (private)' do
    it 'finds the form with associations' do
      found = presenter.send(:find_form)
      expect(found).to eq(form)
      expect(found.class_forms.first.class_group).to eq(class_group)
      expect(found.subject).to eq(subject)
      expect(found.template).to eq(template)
    end

    it 'returns nil if not found' do
      bad_presenter = described_class.new(form_id: -999)
      expect(bad_presenter.send(:find_form)).to be_nil
    end
  end
end
