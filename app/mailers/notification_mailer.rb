class NotificationMailer < ActionMailer::Base
  default from: 'Norte Sul Energia <donotreply@nortesulenergia.com>'

  def envia_pdf_cliente(calculadora, subject, pdf)
    attachments["orcamento.pdf"] = pdf

    @calculadora = calculadora
    mail(to: @calculadora.email, subject: subject)
  end

  def envia_pdf_empresa(calculadora, subject, pdf)
    attachments["orcamento.pdf"] = pdf

    @calculadora = calculadora
    mail(to: 'contato@nortesulenergia.com', subject: subject)
  end
end
