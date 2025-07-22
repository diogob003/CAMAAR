# Entidade do sistema responsavel por representar um formulario
# está associado a várias outras entidades
# pode ser respondido pelos alunos da turma atribuida
class Form < ApplicationRecord
  belongs_to :publisher, class_name: "User"
  belongs_to :template

  has_many :class_forms
  has_many :class_groups, through: :class_forms

  has_many :answered_forms

  # Retorna o primeiro grupo de turma associado ao formulário.
  # Sem parâmetros.
  # @return [ClassGroup] primeiro grupo de turma
  def first_class_group
    class_forms.first.class_group
  end

  # Retorna a disciplina do primeiro grupo de turma.
  # Sem parâmetros.
  # @return [Subject] disciplina do grupo
  def subject
    first_class_group.subject
  end

  # Retorna o template associado ao formulário.
  # Sem parâmetros.
  # @return [Template] template do formulário
  def template
    super
  end

  # Busca formulários publicados por um usuário.
  # @param user [User] usuário publisher
  # @return [ActiveRecord::Relation] formulários encontrados
  def self.find_by_publisher(user)
    where(publisher_id: user.id).includes(:template, class_groups: :subject)
  end

  # Atribui objetos Subject às turmas associadas.
  # Sem parâmetros.
  def assign_subjects!
    class_groups.each do |class_group|
      class_group.subject = Subject.find(class_group.subject_id)
    end
  end
end
