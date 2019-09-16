class Contact < MailForm::Base
  attribute :nome, :email, :telefone, :estado, :cidade, :mensagem

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => 'Mensagem do site',
        :to => 'donotreply@nortesulenergia.com',
        :from => %("#{nome}" <#{email}>)
    }
  end
end
