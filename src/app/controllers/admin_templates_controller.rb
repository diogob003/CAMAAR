class AdminTemplatesController < ApplicationController
  before_action :require_login, only: [:list, :create, :edit, :update, :destroy]
  before_action :set_template, only: [:edit, :update, :destroy]
  before_action :authorize_template, only: [:edit, :update, :destroy]

  def index; end

  def list
    @templates = Template.where(creator_id: current_user.id)
  end

  def new
    @template = Template.new
    @template.questions.build
  end

  def create
    if template_params[:title].blank?
      redirect_to admin_templates_list_path, alert: "Template name can't be blank." and return
    end

    template = build_template_with_creator

    if template.save
      redirect_to admin_templates_list_path, notice: "Template created successfully."
    else
      @template = template
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    TemplateSorter.sort_questions_and_options(@template)
    TemplateBuilder.build_question_if_empty(@template)
    render :edit, notice: "Edit successfully"
  end

  def update
    if @template.update(template_params)
      redirect_to admin_templates_list_path, notice: "Template updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @template.forms.exists?
      redirect_to admin_templates_list_path, alert: "Cannot delete: template has associated forms."
    else
      @template.destroy
      redirect_to admin_templates_list_path, notice: "Template deleted successfully."
    end
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

  def build_template_with_creator
    template = Template.new(template_params)
    template.creator_id = current_user.id
    template
  end

  def template_params
    params.require(:template).permit(
      :title, :description,
      questions_attributes: [
        :id, :title, :answer_type, :order, :_destroy,
        options_attributes: [:id, :description, :order, :_destroy]
      ]
    )
  end
end