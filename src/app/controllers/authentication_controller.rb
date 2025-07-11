class AuthenticationController < ApplicationController
  def index
  end

  def login
    # usuario = Usuario.find_by(email: params[:email])
    # if usuario && usuario.authenticate(params[:password])
    #   session[:usuario_id] = usuario.id
    #   redirect_to root_path, notice: "Logged in!"
    # else
    #   flash.now[:alert] = "Invalid email or password"
    #   render :index, status: :unauthorized
    # end

    # Mockando, isso deve ser implementado depois!!!!!
    usuario = Usuario.find_by(cargo: "aluno")
    if usuario
      session[:usuario_id] = usuario.id
      redirect_to authenticated_index_path, notice: "Logged in!"
    else
      flash.now[:alert] = "No 'aluno' user found"
      render :index, status: :unprocessable_entity
    end
  end
end
