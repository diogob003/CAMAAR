# Controller para ações de usuários autenticados (home e admin).
# Usa AuthenticatedHelperService e AdminDashboardPresenter.
class AuthenticatedController < ApplicationController
  # Garante que o usuário esteja autorizado antes de acessar home ou admin.
  # Sem parâmetros. Pode bloquear acesso (efeito colateral).
  before_action :authorized, only: [ :home, :admin ]

  # Exibe a página inicial do usuário autenticado.
  # Usa AuthenticatedHelperService para buscar dados.
  # Sem parâmetros diretos.
  # Modifica @forms_data (efeito colateral).
  # Retorna erro 401 se não estiver logado.
  def home
    return head :unauthorized unless logged_in?
    user = current_user
    class_group_ids = AuthenticatedHelperService.fetch_class_group_ids(user)
    forms = AuthenticatedHelperService.fetch_forms(class_group_ids, params[:query])
    @forms_data = AuthenticatedHelperService.build_forms_data(forms, user)
  end

  # Exibe o painel administrativo.
  # Usa AdminDashboardPresenter para montar os dados.
  # Sem parâmetros diretos.
  # Modifica @classrooms, @templates, @sent_forms (efeito colateral).
  # Retorna erro 401 se não estiver logado.
  def admin
    return head :unauthorized unless logged_in?
    data = AdminDashboardPresenter.new(current_user, params[:query]).data
    @classrooms, @templates, @sent_forms = data.values_at(:classrooms, :templates, :sent_forms)
  end
end
