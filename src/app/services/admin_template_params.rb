# Classe que contem os parametros de rota que o controller de templates
# usa nas suas rotas
class AdminTemplateParams
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
