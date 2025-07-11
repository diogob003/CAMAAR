class AuthenticatedController < ApplicationController
  def index
  end

  def destroy
    session[:usuario_id] = nil
  end
end
