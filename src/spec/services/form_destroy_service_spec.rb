require 'rails_helper'

RSpec.describe FormDestroyService, type: :service do
  let(:user) { test_user }
  let(:class_group) { test_class_group(user) }
  let(:template) { test_template(user) }
  let(:form) { test_form(class_group, user, template) }
  let(:class_form) { ClassForm.find_by(form_id: form.id, class_group_id: class_group.id) }
  let(:params) { { id: form.id, class_form_id: class_form.id } }

  describe '.call' do
=begin
    context 'when form has no answers' do
      it 'destroys form and class_form, returns success result' do
        expect {
          result = described_class.call(params)
          expect(result).to eq(path: "/list_forms", alert: nil, notice: "Form deleted successfully.")
        }.to change(Form, :count).by(-1).and change(ClassForm, :count).by(-1)
      end
    end
=end

    context 'when form has answers' do
      before do
        AnsweredForm.create!(user: user, form: form)
      end

      it 'does not destroy, returns cannot delete result' do
        expect {
          result = described_class.call(params)
          expect(result).to eq(path: "/list_forms", alert: "Cannot delete: form has associated answers.", notice: nil)
        }.not_to change(Form, :count)
      end
    end
  end

  describe '.find_form' do
    it 'finds the form by id' do
      expect(described_class.find_form(params)).to eq(form)
    end
  end

  describe '.find_class_form' do
    it 'finds the class_form by id' do
      expect(described_class.find_class_form(params)).to eq(class_form)
    end
  end

  describe '.has_answers?' do
    it 'returns false if no answers' do
      expect(described_class.has_answers?(form)).to be_falsey
    end

    it 'returns true if there are answers' do
      AnsweredForm.create!(user: user, form: form)
      expect(described_class.has_answers?(form)).to be_truthy
    end
  end

  describe '.cannot_delete_result' do
    it 'returns cannot delete hash' do
      expect(described_class.cannot_delete_result).to eq(path: "/list_forms", alert: "Cannot delete: form has associated answers.", notice: nil)
    end
  end

=begin
  describe '.destroy_form_and_class_form' do
    it 'destroys both form and class_form' do
      expect {
        described_class.destroy_form_and_class_form(form, class_form)
      }.to change(Form, :count).by(-1)
                               .and change(ClassForm, :count).by(-1)
    end
  end
=end

  describe '.success_result' do
    it 'returns success hash' do
      expect(described_class.success_result).to eq(path: "/list_forms", alert: nil, notice: "Form deleted successfully.")
    end
  end
end
