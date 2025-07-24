require "csv"

# Controller usado apenas para simplificar as ações de autenticação
# possui metodos que sao chamados por outros controllers
class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def current_user
    user_id = session[:user_id]
    if user_id
      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    unless logged_in?
      redirect_to login_path
    end
  end
end
