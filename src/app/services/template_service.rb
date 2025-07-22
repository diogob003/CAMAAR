# Serviço para gerenciar templates de formulários
class TemplateService
  # Lista templates criados pelo usuário.
  # @param user [User] usuário atual
  # @return [ActiveRecord::Relation] templates do usuário
  def self.list_for_user(user)
    Template.where(creator_id: user.id)
  end

  # Cria novo template com uma questão.
  # @return [Template] novo template
  def self.new_template
    template = Template.new
    template.questions.build
    template
  end

  # Cria template com dados informados.
  # @param params [Hash] dados do template
  # @param user [User] usuário criador
  # @return [Hash] resultado da criação
  # Efeito colateral: Salva template no banco.
  def self.create_template(params, user)
    return { success: false, template: Template.new(params), error: "Template name can't be blank." } if params[:title].blank?
    template = Template.new(params)
    template.creator_id = user.id
    { success: template.save, template: template }
  end

  # Prepara template para edição usando o TemplateSorter e TemplateBuilder.
  # @param template [Template] template a editar
  # @return [Template] template pronto para edição
  # Efeito colateral: Modifica questões do template.
  def self.prepare_for_edit(template)
    TemplateSorter.sort_questions_and_options(template)
    TemplateBuilder.build_question_if_empty(template)
    template
  end

  # Atualiza template com novos dados.
  # @param template [Template] template existente
  # @param params [Hash] dados atualizados
  # @return [Boolean] sucesso da atualização
  def self.update_template(template, params)
    template.update(params)
  end

  # Exclui template se não houver formulários associados.
  # @param template [Template] template a excluir
  # @return [Hash] resultado da exclusão
  # Efeito colateral: Remove template do banco.
  def self.destroy_template(template)
    if template.forms.exists?
      { alert: "Cannot delete: template has associated forms.", notice: nil }
    else
      template.destroy
      { notice: "Template deleted successfully.", alert: nil }
    end
  end
end
