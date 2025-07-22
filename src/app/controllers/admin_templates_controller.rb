# Controller responsavel por gerenciar as rotas de templates
# criação, edição, listagem e exclusão
# Usa TemplateService e AdminTemplateParams.
class AdminTemplatesController < ApplicationController
  before_action :require_login, only: [ :list, :create, :edit, :update, :destroy ]
  before_action :set_template, only: [ :edit, :update, :destroy ]
  before_action :authorize_template, only: [ :edit, :update, :destroy ]

  # Exibe a página inicial de templates.
  # Sem parâmetros. Sem retorno.
  def index; end

  # Lista templates do usuário usando TemplateService.
  # Modifica @templates (efeito colateral).
  def list
    @templates = TemplateService.list_for_user(current_user)
  end

  # Prepara um novo template usando TemplateService.
  # Modifica @template (efeito colateral).
  def new
    @template = TemplateService.new_template
  end

  # Cria um template com TemplateService.
  # Redireciona ou renderiza página (efeito colateral).
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

  # Prepara template para edição com TemplateService.
  # Modifica @template e renderiza página (efeito colateral).
  def edit
    @template = TemplateService.prepare_for_edit(@template)
    render :edit, notice: "Edit successfully"
  end

  # Atualiza template com TemplateService.
  # Redireciona ou renderiza página (efeito colateral).
  def update
    if TemplateService.update_template(@template, template_params)
      redirect_to admin_templates_list_path, notice: "Template updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Exclui template com TemplateService.
  # Redireciona para lista (efeito colateral).
  def destroy
    result = TemplateService.destroy_template(@template)
    redirect_to admin_templates_list_path, notice: result[:notice], alert: result[:alert]
  end

  private

  # Exige login para ações protegidas.
  # Sem parâmetros. Sem retorno. Pode bloquear acesso (efeito colateral).
  def require_login
    head :unauthorized unless logged_in?
  end

  # Busca o template pelo ID informado em params.
  # Sem parâmetros diretos. Modifica @template (efeito colateral).
  def set_template
    @template = Template.find(params[:id])
  end

  # Verifica se o usuário pode editar o template.
  # Redireciona se não autorizado (efeito colateral).
  def authorize_template
    redirect_to admin_templates_list_path, alert: "You are not authorized to edit this template." unless @template.creator_id == current_user.id
  end

  # Permite apenas parâmetros válidos para template.
  # @return [ActionController::Parameters] parâmetros permitidos
  def template_params
    AdminTemplateParams.permit(params)
  end
end
