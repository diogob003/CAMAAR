class AdminTemplatesController < ApplicationController
  def index
  end

  def list
    return head :unauthorized unless logged_in?
    user = current_user
    @templates = Template.where(creator_id: current_user.id)
  end

  def new
    @template = Template.new
    @template.questions.build
  end

  def create

    if template_params[:title].blank?
      redirect_to admin_templates_list_path, alert: "Template name can't be blank."
      return
    end

    @template = Template.new(template_params)
    @template.creator_id = current_user.id

    if @template.save
      redirect_to admin_templates_list_path, notice: "Template created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @template = Template.find(params[:id])
    if @template.creator_id != current_user.id
      redirect_to admin_templates_list_path, alert: "You are not authorized to edit this template."
    else
      @template.questions = @template.questions.sort_by(&:order)
      @template.questions.each do |q|
        q.options = q.options.sort_by(&:order)
      end
      @template.questions.build if @template.questions.empty?
      render :edit, notice: "Edit successfully"
    end
  end

  def update
    @template = Template.find(params[:id])
    if @template.creator_id != current_user.id
      redirect_to admin_templates_list_path, alert: "You are not authorized to edit this template."
    elsif @template.update(template_params)
      redirect_to admin_templates_list_path, notice: "Template updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    template = Template.find(params[:id])
    if template.forms.exists?
      redirect_to admin_templates_list_path, alert: "Cannot delete: template has associated forms."
    else
      template.destroy
      redirect_to admin_templates_list_path, notice: "Template deleted successfully."
    end
  end

  private

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
