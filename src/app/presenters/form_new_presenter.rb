# Organiza os dados para a view de criação de um novo formulário
class FormNewPresenter
  def initialize(user_id)
    @user_id = user_id
    @user = User.find_by(id: user_id) if user_id
  end

  def present
    return [ nil, [], [], [], Form.new ] unless @user_id
    user = @user
    [ user, user.class_groups, user.templates, user.subject_ids, Form.new ]
  end
end
