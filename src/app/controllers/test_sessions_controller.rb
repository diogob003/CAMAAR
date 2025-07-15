class TestSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    session[:user_id] = params[:user_id]
    head :ok
  end
end
