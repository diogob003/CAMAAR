# Entidade do sistema responsavel por representar um formulario
# está associado a várias outras entidades
# pode ser respondido pelos alunos da turma atribuida
class Form < ApplicationRecord
  belongs_to :publisher, class_name: "User"
  belongs_to :template

  has_many :class_forms
  has_many :class_groups, through: :class_forms

  has_many :answered_forms

  def first_class_group
    class_forms.first.class_group
  end

  def subject
    first_class_group.subject
  end

  def template
    super
  end

  def self.find_by_publisher(user)
    where(publisher_id: user.id).includes(:template, class_groups: :subject)
  end

  def assign_subjects!
    class_groups.each do |class_group|
      class_group.subject = Subject.find(class_group.subject_id)
    end
  end

end
