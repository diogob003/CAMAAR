# Serviço para simplificar a logica do form_controller
class FormControllerService
  # Prepara variáveis para exibir o formulário.
  # @param params [Hash] parâmetros recebidos
  # @return [Hash] dados para apresentação
  def self.answer_form_vars(params)
    FormAnswerPresenter.new(params).present
  end

  # Submete respostas do formulário usando o FormSubmitService
  # @param params [Hash] respostas e dados do formulário
  # @param user_id [Integer] id do usuário
  # @return [Hash] resultado da submissão
  # Efeito colateral: Cria registros de respostas.
  def self.submit_form(params, user_id)
    FormSubmitService.call(params, user_id)
  end

  # Prepara variáveis para novo formulário.
  # @param user_id [Integer] id do usuário
  # @return [Hash] dados para apresentação
  def self.new_form_vars(user_id)
    FormNewPresenter.new(user_id).present
  end

  # Envia formulário para usuários usando o FormSendService.
  # @param params [Hash] dados do formulário
  # @param user_id [Integer] id do usuário
  # @return [Hash] resultado do envio
  def self.send_form(params, user_id)
    FormSendService.call(params, user_id)
  end

  # Gera resultado em CSV do formulário usando o FOrmDownloadService
  # @param form_id [Integer] id do formulário
  # @return [String] conteúdo CSV
  def self.csv_result(form_id)
    FormDownloadService.call(form_id)
  end

  # Exclui formulário chamando o FormDestroyService.
  # @param params [Hash] dados do formulário
  # @return [Hash] resultado da exclusão
  # Efeito colateral: Remove registros do banco.
  def self.destroy_form(params)
    FormDestroyService.call(params)
  end
end
