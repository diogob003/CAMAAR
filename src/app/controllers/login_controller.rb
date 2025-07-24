# Handles user login and logout actions.
class LoginController < ApplicationController
  def index
  end

  def login
    user = find_user(params[:email_enrollment].strip)

    if user && user.authenticate(params[:password])
      log_in_user(user)
    else
      handle_failed_login
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def find_user(email_enrollment)
    if email_enrollment =~ /.+@.+\..+/
      User.find_by_email(email_enrollment)
    else
      User.find_by_registration(email_enrollment)
    end
  end

  def log_in_user(user)
    session[:user_id] = user.id
    redirect_to authenticated_home_path, notice: "Logged in!"
  end

  def handle_failed_login
    flash.now[:alert] = "Senha ou email inválido"
    render :index, status: :unprocessable_entity
  end
end
