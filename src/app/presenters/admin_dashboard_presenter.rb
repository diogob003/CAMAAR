# Classe utilitaria para encapsular a logica
# de representar os dados do admin
class AdminDashboardPresenter
  def initialize(user, query)
    @user = user
    @query = query
  end

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
