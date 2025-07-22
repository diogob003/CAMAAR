# Organiza os dados para a view de criação de um novo formulário
class FormNewPresenter
  # Inicializa o presenter com o ID do usuário.
  # @param user_id [Integer] ID do usuário
  # @return [void]
  def initialize(user_id)
    @user_id = user_id
    @user = User.find_by(id: user_id) if user_id
  end

  # Retorna os dados necessários para criar um novo formulário.
  # @return [Array] [usuário, grupos, templates, IDs de disciplinas, novo formulário]
  # Retorna valores vazios se não houver usuário.
  def present
    return [ nil, [], [], [], Form.new ] unless @user_id
    user = @user
    [ user, user.class_groups, user.templates, user.subject_ids, Form.new ]
  end
end
