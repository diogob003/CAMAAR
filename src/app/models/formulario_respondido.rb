class FormularioRespondido < ApplicationRecord
  belongs_to :usuario
  belongs_to :formulario
end
