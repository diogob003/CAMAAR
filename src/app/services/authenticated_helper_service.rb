# Classe responsavel nas queries do banco relacionadas a formularios do usuario logado
# Usada principalmente AuthenticatedController
class AuthenticatedHelperService

  # Busca todos os IDs de grupos de turma onde o usuário é aluno ou professor.
  # @param user [User] usuário logado
  # @return [Array<Integer>] lista única de IDs das turmas
  def self.fetch_class_group_ids(user)
    (class_student_ids(user) + class_professor_ids(user)).uniq
  end

  # Busca formulários pelos IDs das turmas e filtro de busca pelo nome da disciplina (opcional).
  # @param class_group_ids [Array<Integer>] IDs dos grupos
  # @param query [String] filtro de busca (nome da disciplina)
  # @return [ActiveRecord::Relation] formulários encontrados
  def self.fetch_forms(class_group_ids, query)
    query.present? ? forms_with_query(class_group_ids, query) : forms_without_query(class_group_ids)
  end

  # Monta dados para exibição de uma lista de formulários.
  # @param forms [Enumerable] lista de formulários
  # @param user [User] usuário logado
  # @return [Array<Hash>] dados dos formulários para exibição
  def self.build_forms_data(forms, user)
    forms.map { |form| build_form_data(form, user) }.compact
  end

  private

  # Busca IDs dos grupos onde o usuário é aluno.
  # @param user [User] usuário logado
  # @return [Array<Integer>] IDs dos grupos
  def self.class_student_ids(user)
    user.class_students.pluck(:class_group_id)
  end

  # Busca IDs dos grupos onde o usuário é professor.
  # @param user [User] usuário logado
  # @return [Array<Integer>] IDs dos grupos
  def self.class_professor_ids(user)
    user.class_professors.pluck(:class_group_id)
  end

  # Busca formulários filtrando pelo nome da disciplina.
  # @param class_group_ids [Array<Integer>] IDs dos grupos
  # @param query [String] texto de busca
  # @return [ActiveRecord::Relation] formulários encontrados
  def self.forms_with_query(class_group_ids, query)
    Form.joins(class_forms: { class_group: :subject })
        .where(class_forms: { class_group_id: class_group_ids })
        .where("subjects.name LIKE ?", "%#{query}%")
        .distinct
  end

  # Busca formulários sem filtro de busca.
  # @param class_group_ids [Array<Integer>] IDs dos grupos
  # @return [ActiveRecord::Relation] formulários encontrados
  def self.forms_without_query(class_group_ids)
    Form.joins(:class_forms)
        .where(class_forms: { class_group_id: class_group_ids })
        .distinct
  end

  # Monta dados para exibição de um formulário.
  # @param form [Form] formulário
  # @param user [User] usuário logado
  # @return [Hash] dados do formulário
  def self.build_form_data(form, user)
    FormDataPresenter.new(form, user).as_json
  end

  # Busca o nome do primeiro professor da turma.
  # @param class_group [ClassGroup] turma
  # @return [String, nil] nome do professor ou nil
  def self.first_professor_name(class_group)
    class_group.class_professors.first&.professor&.name
  end

end
