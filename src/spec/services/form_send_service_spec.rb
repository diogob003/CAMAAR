require 'rails_helper'

RSpec.describe FormSendService, type: :service do
  let(:user) { test_user }
  let(:class_group) { test_class_group(user) }
  let(:template) { test_template(user) }
  let(:params) { { template_id: template.id, class_group_id: class_group.id } }

  describe '.call' do
    context 'when user_id is nil' do
      it 'returns unauthorized result' do
        result = described_class.call(params, nil)
        expect(result).to eq(path: "/new_form", alert: "Unauthorized")
      end
    end

    context 'when form already exists' do
      before do
        form = Form.create!(publisher_id: user.id, template_id: template.id)
        ClassForm.create!(class_group_id: class_group.id, form: form)
      end

      it 'returns already exists result' do
        result = described_class.call(params, user.id)
        expect(result).to eq(path: "/list_forms", alert: "Already exists an form for this class with the same template.")
      end
    end

    context 'when form is created successfully' do
      it 'creates form and class_form, returns success result' do
        expect {
          result = described_class.call(params, user.id)
          expect(result).to eq(path: "/list_forms", notice: "Form created successfully.")
        }.to change(Form, :count).by(1).and change(ClassForm, :count).by(1)
      end
    end

    context 'when form or class_form fails to save' do
      before do
        allow_any_instance_of(Form).to receive(:save).and_return(false)
      end

      it 'returns error result' do
        result = described_class.call(params, user.id)
        expect(result).to eq(path: "/new_form", alert: "Error creating form")
      end
    end
  end

  describe '.unauthorized_result' do
    it 'returns unauthorized hash' do
      expect(described_class.unauthorized_result).to eq(path: "/new_form", alert: "Unauthorized")
    end
  end

  describe '.form_exists?' do
    it 'returns false if no form exists' do
      expect(described_class.form_exists?(user.id, params)).to be_falsey
    end

    it 'returns true if form exists' do
      form = Form.create!(publisher_id: user.id, template_id: template.id)
      ClassForm.create!(class_group_id: class_group.id, form: form)
      expect(described_class.form_exists?(user.id, params)).to be_truthy
    end
  end

  describe '.already_exists_result' do
    it 'returns already exists hash' do
      expect(described_class.already_exists_result).to eq(path: "/list_forms", alert: "Already exists an form for this class with the same template.")
    end
  end

  describe '.build_form_and_class_form' do
    it 'returns new form and class_form objects' do
      form, class_form = described_class.build_form_and_class_form(user.id, params)
      expect(form).to be_a(Form)
      expect(form.publisher_id).to eq(user.id)
      expect(form.template_id).to eq(template.id)
      expect(class_form).to be_a(ClassForm)
      expect(class_form.class_group_id).to eq(class_group.id)
      expect(class_form.form).to eq(form)
    end
  end

  describe '.success_result' do
    it 'returns success hash' do
      expect(described_class.success_result).to eq(path: "/list_forms", notice: "Form created successfully.")
    end
  end

  describe '.error_result' do
    it 'returns error hash' do
      expect(described_class.error_result).to eq(path: "/new_form", alert: "Error creating form")
    end
  end
end
