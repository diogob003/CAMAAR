# Classe utilitaria para encapsular a logica
# de representar os dados do admin
class AdminDashboardPresenter
  # Inicializa o presenter com usuário e filtro de busca.
  # @param user [User] usuário logado
  # @param query [String] texto de busca
  def initialize(user, query)
    @user = user
    @query = query
  end

  # Retorna os dados do painel do admin.
  # @return [Hash] dados: turmas, templates e formulários enviados
  def data
    user_id = @user.id
    class_group_ids = AuthenticatedHelperService.fetch_class_group_ids(@user)
    {
      classrooms: ClassGroup.where(id: class_group_ids),
      templates: Template.where(creator_id: user_id),
      sent_forms: Form.where(publisher_id: user_id)
    }
  end
end
