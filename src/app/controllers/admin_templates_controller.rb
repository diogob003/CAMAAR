# Controller responsavel por gerenciar as rotas de templates
# criação, edição, listagem e exclusão
class AdminTemplatesController < ApplicationController
  before_action :require_login, only: [:list, :create, :edit, :update, :destroy]
  before_action :set_template, only: [:edit, :update, :destroy]
  before_action :authorize_template, only: [:edit, :update, :destroy]

  def index; end

  def list
    @templates = TemplateService.list_for_user(current_user)
  end

  def new
    @template = TemplateService.new_template
  end

  def create
    result = TemplateService.create_template(template_params, current_user)
    error = result[:error]
    if result[:success]
      redirect_to admin_templates_list_path, notice: "Template created successfully."
    elsif error
      redirect_to admin_templates_list_path, alert: error
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @template = TemplateService.prepare_for_edit(@template)
    render :edit, notice: "Edit successfully"
  end

  def update
    if TemplateService.update_template(@template, template_params)
      redirect_to admin_templates_list_path, notice: "Template updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    result = TemplateService.destroy_template(@template)
    redirect_to admin_templates_list_path, notice: result[:notice], alert: result[:alert]
  end

  private

  def require_login
    head :unauthorized unless logged_in?
  end

  def set_template
    @template = Template.find(params[:id])
  end

  def authorize_template
    redirect_to admin_templates_list_path, alert: "You are not authorized to edit this template." unless @template.creator_id == current_user.id
  end

  def template_params
    AdminTemplateParams.permit(params)
  end
end