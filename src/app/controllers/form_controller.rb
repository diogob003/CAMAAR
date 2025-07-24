# Controller responsavel ppor tudo que envolve formulários
# listagem, criacao, responder e etc
# Usa FormControllerService e FormListPresenter

class FormController < ApplicationController
  # Exibe a página inicial de formulários.
  # Sem parâmetros. Sem retorno.
  def index; end

  # Exibe formulário para resposta.
  # @param params [Hash] parâmetros do formulário
  # Usa FormControllerService.
  # Modifica variáveis de instância (efeito colateral).
  def answer_form
    @form, @class_group, @subject, @template, @questions =
      FormControllerService.answer_form_vars(params)
  end

  # Submete respostas de formulário.
  # @param params [Hash] respostas do formulário
  # Redireciona para home autenticada (efeito colateral).
  # Usa FormControllerService.
  def submit_form
    result = FormControllerService.submit_form(params, session[:user_id])
    flash[result[:type]] = result[:message]
    redirect_to authenticated_home_path
  end

  # Lista formulários do usuário.
  # Usa FormListPresenter.
  # Modifica @forms (efeito colateral).
  def list
    @forms = FormListPresenter.new(session[:user_id]).present
  end

  # Prepara dados para criação de novo formulário.
  # Usa FormControllerService.
  # Modifica variáveis de instância (efeito colateral).
  def new_form
    @user, @class_groups, @templates, @subject_ids, @form =
      FormControllerService.new_form_vars(session[:user_id])
  end

  # Envia formulário para destinatários.
  # @param params [Hash] dados do formulário
  # Redireciona conforme resultado (efeito colateral).
  # Usa FormControllerService.
  def send_form
    result = FormControllerService.send_form(params, session[:user_id])
    redirect_to result[:path], alert: result[:alert], notice: result[:notice]
  end

  # Exibe resultados dos formulários.
  # Usa FormListPresenter.
  # Modifica @forms (efeito colateral).
  def results
    @forms = FormListPresenter.new(session[:user_id]).present
  end

  # Faz download dos resultados em CSV.
  # @param params[:form_id] [int] ID do formulário
  # Usa FormControllerService.
  # Envia arquivo CSV (efeito colateral).
  def download_result
    csv_data = FormControllerService.csv_result(params[:form_id])
    send_data csv_data[:data], filename: csv_data[:filename], type: "text/csv"
  end

  # Exclui formulário.
  # @param params [Hash] dados do formulário
  # Redireciona conforme resultado (efeito colateral).
  # Usa FormControllerService.
  def destroy
    result = FormControllerService.destroy_form(params)
    redirect_to result[:path], alert: result[:alert], notice: result[:notice]
  end
end
