# Classe utilizada como base para todos os outros modelos
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
