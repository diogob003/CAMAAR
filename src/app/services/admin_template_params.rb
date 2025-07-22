# Classe que contem os parametros de rota que o controller de templates
# usa nas suas rotas
class AdminTemplateParams
  # Permite apenas os parâmetros necessários para template e questões.
  # @param params [ActionController::Parameters] parâmetros recebidos
  # @return [ActionController::Parameters] parâmetros permitidos
  def self.permit(params)
    params.require(:template).permit(
      :title, :description,
      questions_attributes: [
        :id, :title, :answer_type, :order, :_destroy,
        options_attributes: [ :id, :description, :order, :_destroy ]
      ]
    )
  end
end
