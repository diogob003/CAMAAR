# Representa um usuário do sistema
# pode ser aluno ou professor
# e está associado a várias turmas
class User < ApplicationRecord
  has_secure_password

  has_many :class_professors, foreign_key: :professor_id
  has_many :teaching_classes, through: :class_professors, source: :class_group

  has_many :class_students, foreign_key: :student_id
  has_many :attending_classes, through: :class_students, source: :class_group

  has_many :templates, foreign_key: :creator_id
  has_many :forms_published, class_name: "Form", foreign_key: :publisher_id

  has_many :answered_forms

  validates :email, presence: true, uniqueness: true
  validates :registration, presence: true, uniqueness: true

  # Retorna as turmas que o usuário leciona.
  # Sem parâmetros.
  # @return [ActiveRecord::Relation] turmas do usuário
  def class_groups
    ids = respond_to?(:class_professors) ? class_professors.pluck(:class_group_id).uniq : []
    ClassGroup.where(id: ids)
  end

  # Retorna os templates criados pelo usuário.
  # Sem parâmetros.
  # @return [ActiveRecord::Relation] templates do usuário
  def templates
    Template.where(creator_id: id)
  end

  # Retorna os IDs das disciplinas das turmas do usuário.
  # Sem parâmetros.
  # @return [Array<Integer>] lista de IDs de disciplinas
  def subject_ids
    class_groups.map(&:subject_id)
  end
end
