# Classe para organizar os dados que serao mostrados
# na lista de formulários
class FormListPresenter
  # Inicializa com o ID do usuário.
  # @param user_id [Integer] ID do usuário
  def initialize(user_id)
    @user_id = user_id
  end

  # Retorna os formulários publicados pelo usuário, já com as disciplinas atribuídas.
  # @return [Array<Form>] lista de formulários ou vazio se não houver usuário
  def present
    return [] unless @user_id
    user = find_user
    forms = Form.find_by_publisher(user)
    assign_subjects(forms)
    forms
  end

  private

  # Busca o usuário pelo ID.
  # @return [User] usuário encontrado
  def find_user
    User.find(@user_id)
  end

  # Atribui as disciplinas aos formulários.
  # @param forms [Array<Form>] lista de formulários
  # @return [void] modifica os formulários (efeito colateral)
  def assign_subjects(forms)
    forms.each(&:assign_subjects!)
  end
end
