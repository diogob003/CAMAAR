# Classe default do rails usada para enviar emails
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
