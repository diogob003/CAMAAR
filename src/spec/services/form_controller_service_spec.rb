require 'rails_helper'

RSpec.describe FormControllerService do
  let(:user) { test_user }
  let(:params) { { form_id: 123, some: 'data' } }
  let(:user_id) { user.id }
  let(:form_id) { 456 }

  describe '.answer_form_vars' do
    it 'delegates to FormAnswerPresenter and returns its result' do
      presenter = instance_double(FormAnswerPresenter)
      expected_result = [ :form, :class_group, :subject, :template, :questions ]
      expect(FormAnswerPresenter).to receive(:new).with(params).and_return(presenter)
      expect(presenter).to receive(:present).and_return(expected_result)
      result = described_class.answer_form_vars(params)
      expect(result).to be(expected_result)
    end
  end

  describe '.submit_form' do
    it 'delegates to FormSubmitService and returns its result' do
      expect(FormSubmitService).to receive(:call).with(params, user_id).and_return({ success: true })
      result = described_class.submit_form(params, user_id)
      expect(result).to eq({ success: true })
    end
  end

  describe '.new_form_vars' do
    it 'delegates to FormNewPresenter and returns its result' do
      presenter = instance_double(FormNewPresenter)
      new_form = Form.new
      expected_result = [ user, [], [], [], new_form ]
      expect(FormNewPresenter).to receive(:new).with(user_id).and_return(presenter)
      expect(presenter).to receive(:present).and_return(expected_result)
      result = described_class.new_form_vars(user_id)
      expect(result).to eq(expected_result)
    end
  end

  describe '.send_form' do
    it 'delegates to FormSendService and returns its result' do
      expect(FormSendService).to receive(:call).with(params, user_id).and_return({ sent: true })
      result = described_class.send_form(params, user_id)
      expect(result).to eq({ sent: true })
    end
  end

  describe '.csv_result' do
    it 'delegates to FormDownloadService and returns its result' do
      expect(FormDownloadService).to receive(:call).with(form_id).and_return("csv,data")
      result = described_class.csv_result(form_id)
      expect(result).to eq("csv,data")
    end
  end

  describe '.destroy_form' do
    it 'delegates to FormDestroyService and returns its result' do
      expect(FormDestroyService).to receive(:call).with(params).and_return({ destroyed: true })
      result = described_class.destroy_form(params)
      expect(result).to eq({ destroyed: true })
    end
  end
end
