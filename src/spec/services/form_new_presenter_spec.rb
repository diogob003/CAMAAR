require 'rails_helper'

RSpec.describe FormNewPresenter do
  let(:user) { test_user }
  let(:presenter) { described_class.new(user.id) }

  describe '#initialize' do
    it 'sets @user_id and @user' do
      expect(presenter.instance_variable_get(:@user_id)).to eq(user.id)
      expect(presenter.instance_variable_get(:@user)).to eq(user)
    end

    it 'sets @user to nil if user_id is nil' do
      p = described_class.new(nil)
      expect(p.instance_variable_get(:@user)).to be_nil
    end
  end

  describe '#present' do
    context 'when user_id is nil' do
      let(:presenter) { described_class.new(nil) }

      it 'returns [nil, [], [], [], Form.new]' do
        result = presenter.present
        expect(result[0]).to be_nil
        expect(result[1]).to eq([])
        expect(result[2]).to eq([])
        expect(result[3]).to eq([])
        expect(result[4]).to be_a(Form)
        expect(result[4]).to be_new_record
      end
    end

    context 'when user_id is present' do
      it 'returns user, class_groups, templates, subject_ids, and new Form' do
        result = presenter.present
        expect(result[0]).to eq(user)
        expect(result[1]).to eq(user.class_groups)
        expect(result[2]).to eq(user.templates)
        expect(result[3]).to eq(user.subject_ids)
        expect(result[4]).to be_a(Form)
        expect(result[4]).to be_new_record
      end

      it 'returns correct class_groups and templates' do
        class_group = test_class_group(user)
        template = test_template(user)
        expect(user.class_groups).to include(class_group)
        expect(user.templates).to include(template)
      end

      it 'returns subject_ids as array of ids' do
        expect(result = presenter.present[3]).to be_a(Array)
        expect(result).to all(be_a(Integer))
      end
    end
  end
end
