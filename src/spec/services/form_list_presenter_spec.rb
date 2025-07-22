require 'rails_helper'

RSpec.describe FormListPresenter do
  let(:user) { test_user }
  let(:presenter) { described_class.new(user.id) }

  describe '#initialize' do
    it 'sets @user_id' do
      expect(presenter.instance_variable_get(:@user_id)).to eq(user.id)
    end
  end

  describe '#present' do
    context 'when user_id is nil' do
      let(:presenter) { described_class.new(nil) }

      it 'returns an empty array' do
        expect(presenter.present).to eq([])
      end
    end

    context 'when user_id is present' do
      before do
        # Ensure at least one form is published by the user
        test_class_group(user)
        test_template(user)
        test_form(test_class_group(user), user)
      end

      it 'returns forms published by the user' do
        forms = presenter.present
        expect(forms).to all(be_a(Form))
        expect(forms).not_to be_empty
        expect(forms.map(&:publisher_id)).to all(eq(user.id))
      end

      it 'assigns subjects to each form' do
        forms = presenter.present
        forms.each do |form|
          expect(form).to respond_to(:assign_subjects!)
        end
      end
    end
  end

  describe '#find_user (private)' do
    it 'finds the user by id' do
      expect(presenter.send(:find_user)).to eq(user)
    end
  end

  describe '#assign_subjects (private)' do
    it 'calls assign_subjects! on each form' do
      forms = [ test_form(test_class_group(user), user) ]
      expect(forms.first).to receive(:assign_subjects!)
      presenter.send(:assign_subjects, forms)
    end
  end
end
