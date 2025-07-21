class AdminTemplateRedirectService
  def initialize(controller)
    @controller = controller
  end

  def blank_title
    @controller.redirect_to @controller.admin_templates_list_path, alert: "Template name can't be blank."
  end

  def created_success
    @controller.redirect_to @controller.admin_templates_list_path, notice: "Template created successfully."
  end

  def edit_success
    @controller.redirect_to @controller.admin_templates_list_path, notice: "Template updated successfully."
  end

  def unauthorized
    @controller.redirect_to @controller.admin_templates_list_path, alert: "You are not authorized to edit this template."
  end

  def has_forms
    @controller.redirect_to @controller.admin_templates_list_path, alert: "Cannot delete: template has associated forms."
  end

  def deleted_success
    @controller.redirect_to @controller.admin_templates_list_path, notice: "Template deleted successfully."
  end
end