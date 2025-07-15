class AdminTemplatesController < ApplicationController
  def index
  end

  def list

    return head :unauthorized unless logged_in?
    user = current_user

    @templates = Template.where(creator_id: current_user.id)

  end
end
