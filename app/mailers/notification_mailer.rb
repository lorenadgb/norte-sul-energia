class NotificationMailer < ActionMailer::Base
  default from: 'donotreply@nortesulenergia.com'

  def envia_pdf_cliente(calculadora, subject)
    @calculadora = calculadora
    mail(to: 'lorenadgb@gmail.com', subject: subject)
  end

  def envia_pdf_empresa(calculadora, subject)
    @calculadora = calculadora
    mail(to: 'lorenadgb@gmail.com', subject: subject)
  end
end
