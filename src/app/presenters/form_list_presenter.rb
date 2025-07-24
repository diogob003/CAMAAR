# Classe para organizar os dados que serao mostrados
# na lista de formulários
class FormListPresenter
  def initialize(user_id)
    @user_id = user_id
  end

  def present
    return [] unless @user_id
    user = find_user
    forms = Form.find_by_publisher(user)
    assign_subjects(forms)
    forms
  end

  private

  def find_user
    User.find(@user_id)
  end

  def assign_subjects(forms)
    forms.each(&:assign_subjects!)
  end
end
