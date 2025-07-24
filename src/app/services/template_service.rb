# Serviço para gerenciar templates de formulários
class TemplateService
  def self.list_for_user(user)
    Template.where(creator_id: user.id)
  end

  def self.new_template
    template = Template.new
    template.questions.build
    template
  end

  def self.create_template(params, user)
    return { success: false, template: Template.new(params), error: "Template name can't be blank." } if params[:title].blank?
    template = Template.new(params)
    template.creator_id = user.id
    { success: template.save, template: template }
  end

  def self.prepare_for_edit(template)
    TemplateSorter.sort_questions_and_options(template)
    TemplateBuilder.build_question_if_empty(template)
    template
  end

  def self.update_template(template, params)
    template.update(params)
  end

  def self.destroy_template(template)
    if template.forms.exists?
      { alert: "Cannot delete: template has associated forms.", notice: nil }
    else
      template.destroy
      { notice: "Template deleted successfully.", alert: nil }
    end
  end
end
