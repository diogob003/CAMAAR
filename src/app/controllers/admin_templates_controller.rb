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
    @template = Template.new(template_params)
    @template.creator_id = current_user.id
    if @template.save
      redirect_to admin_templates_list_path, notice: "Template created successfully."
    else
      render :new, status: :unprocessable_entity
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
