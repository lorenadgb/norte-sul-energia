class ContactMailer < ActionMailer::Base
  default from: 'donotreply@nortesulenergia.com'

  def contact_message(contact)
    @contact = contact
    mail(to: ENV['EMAIL'], subject: 'Contato')
  end
end
