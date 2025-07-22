require 'rails_helper'

RSpec.describe AuthenticatedHelperService do
  let(:user) { test_user }
  let(:class_group) { test_class_group(user) }
  let(:template) { test_template(user) }
  let(:form) { test_form(class_group, user, template) }

  describe '.fetch_class_group_ids' do
    it 'returns unique class_group_ids for student and professor' do
      student_group = class_group
      professor_group = ClassGroup.create!(number: 2, semester: '2025.1', subject_id: Subject.first.id)
      ClassProfessor.create!(professor_id: user.id, class_group_id: professor_group.id)
      ClassStudent.create!(student_id: user.id, class_group_id: student_group.id)
      ids = described_class.fetch_class_group_ids(user)
      expect(ids).to include(student_group.id, professor_group.id)
      expect(ids.uniq).to eq(ids)
    end

    it 'returns empty array if user has no groups' do
      new_user = User.create!(name: 'Test', email: 'test@test.com', registration: 'T123', role: 'student', password: 'test123')
      expect(described_class.fetch_class_group_ids(new_user)).to eq([])
    end
  end

  describe '.fetch_forms' do
    let(:ids) { [ class_group.id ] }

    it 'returns forms with query' do
      subject = Subject.find_or_create_by!(name: 'Math', code: 'MATH101')
      class_group = ClassGroup.find_or_create_by!(number: 1, semester: '2025.1', subject_id: subject.id)
      form = test_form(class_group, user)
      ids = [ class_group.id ]
      result = described_class.fetch_forms(ids, 'Math')
      expect(result).to include(form)
    end

    it 'returns forms without query' do
      form
      result = described_class.fetch_forms(ids, nil)
      expect(result).to include(form)
    end

    it 'returns empty if no forms match' do
      result = described_class.fetch_forms([ 999 ], nil)
      expect(result).to be_empty
    end
  end

  describe '.build_forms_data' do
    it 'returns array of hashes from presenter' do
      forms = [ form ]
      presenter = instance_double(FormDataPresenter)
      allow(FormDataPresenter).to receive(:new).with(form, user).and_return(presenter)
      allow(presenter).to receive(:as_json).and_return({ id: form.id, name: 'Form' })
      result = described_class.build_forms_data(forms, user)
      expect(result).to eq([ { id: form.id, name: 'Form' } ])
    end

    it 'skips nil results from presenter' do
      forms = [ form ]
      presenter = instance_double(FormDataPresenter)
      allow(FormDataPresenter).to receive(:new).with(form, user).and_return(presenter)
      allow(presenter).to receive(:as_json).and_return(nil)
      result = described_class.build_forms_data(forms, user)
      expect(result).to eq([])
    end
  end

  describe '.first_professor_name' do
    it 'returns the name of the first professor' do
      name = described_class.first_professor_name(class_group)
      expect(name).to eq(user.name)
    end

    it 'returns nil if no professor' do
      empty_group = ClassGroup.create!(number: 99, semester: '2025.1', subject_id: Subject.first.id)
      expect(described_class.first_professor_name(empty_group)).to be_nil
    end
  end
end
