class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :telephone, :validate => true
  attribute :city,      :validate => true
  attribute :state,     :validate => true
  attribute :message, :local

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => 'Contato',
        :to => 'donotreply@nortesulenergia.com',
        :from => %("#{name}" <#{email}>)
    }
  end
end
