# Controller responsável pelo login e logout de usuários.
# Usa o serviço UserAuthenticator.
class LoginController < ApplicationController
  # Exibe a página de login.
  # Sem parâmetros. Sem retorno.
  def index
  end

  # Realiza o login do usuário
  # @param params[:email_enrollment] [String] email ou matrícula do usuário
  # @param params[:password] [String] senha do usuário
  # Redireciona para área autenticada se sucesso
  def login
    user = find_user(params[:email_enrollment].strip)

    if user && user.authenticate(params[:password])
      log_in_user(user)
    else
      handle_failed_login
    end
  end

  # Realiza logout do usuário e redireciona para a página inicial.
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  # Procura e retorna um usuário
  # @param params[:email_enrollment] [String] email ou matrícula do usuário.
  def find_user(email_enrollment)
    if email_enrollment =~ /.+@.+\..+/
      User.find_by_email(email_enrollment)
    else
      User.find_by_registration(email_enrollment)
    end
  end

  # Salva o usuário na sessão e redireciona para home autenticada.
  # @param user [User] usuário autenticado
  # Redireciona para home (efeito colateral).
  def log_in_user(user)
    session[:user_id] = user.id
    redirect_to authenticated_home_path, notice: "Logged in!"
  end

  # Exibe mensagem de erro e renderiza página de login.
  # Sem parâmetros.
  # Renderiza login com status de erro (efeito colateral).
  def handle_failed_login
    flash.now[:alert] = "Senha ou email inválido"
    render :index, status: :unprocessable_entity
  end
end
