# Handles authenticated user actions such as home and admin dashboards.
class AuthenticatedController < ApplicationController
  before_action :authorized, only: [:home, :admin]

  def home
    return head :unauthorized unless logged_in?
    user = current_user
    class_group_ids = AuthenticatedHelperService.fetch_class_group_ids(user)
    forms = AuthenticatedHelperService.fetch_forms(class_group_ids, params[:query])
    @forms_data = AuthenticatedHelperService.build_forms_data(forms, user)
  end

  def admin
    return head :unauthorized unless logged_in?
    data = AdminDashboardPresenter.new(current_user, params[:query]).data
    @classrooms, @templates, @sent_forms = data.values_at(:classrooms, :templates, :sent_forms)
  end
end