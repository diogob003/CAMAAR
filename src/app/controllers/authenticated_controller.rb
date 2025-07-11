class AuthenticatedController < ApplicationController
  def index
  end

  def destroy
    session[:user_id] = nil
  end
end
