require "csv"

# Controller usado apenas para simplificar as ações de autenticação
# possui metodos que sao chamados por outros controllers
class ApplicationController < ActionController::Base
  # Torna os métodos de autenticação acessíveis nas views.
  helper_method :logged_in?, :current_user

  # Retorna o usuário logado, se houver.
  # Sem parâmetros.
  # @return [User, nil] usuário logado ou nil
  def current_user
    user_id = session[:user_id]
    if user_id
      @user = User.find(user_id)
    end
  end

  # Verifica se há usuário logado.
  # Sem parâmetros.
  # @return [Boolean] true se logado, false caso contrário
  def logged_in?
    !!current_user
  end

  # Redireciona para login se não estiver logado.
  # Sem parâmetros.
  # Redireciona para a página de login (efeito colateral).
  def authorized
    unless logged_in?
      redirect_to login_path
    end
  end
end
