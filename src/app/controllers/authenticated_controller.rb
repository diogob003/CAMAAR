# Handles authenticated user actions such as home and admin dashboards.
class AuthenticatedController < ApplicationController
  before_action :authorized, only: [:home, :admin]

  def home
    return head :unauthorized unless logged_in?
    user = current_user
    class_group_ids = AuthenticatedHelperService.fetch_class_group_ids(user)
    query = params[:query]
    forms = AuthenticatedHelperService.fetch_forms(class_group_ids, query)
    @forms_data = AuthenticatedHelperService.build_forms_data(forms, user)
  end

  def admin
    return head :unauthorized unless logged_in?
    user = current_user
    user_id = user.id
    class_group_ids = AuthenticatedHelperService.fetch_class_group_ids(user)
    @classrooms = ClassGroup.where(id: class_group_ids)
    @templates = Template.where(creator_id: user_id)
    @sent_forms = Form.where(publisher_id: user_id)
  end
end