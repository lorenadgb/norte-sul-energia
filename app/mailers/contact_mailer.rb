class ContactMailer < ActionMailer::Base
  default from: 'Norte Sul Energia <donotreply@nortesulenergia.com>'

  def contact_message(contact, subject)
    @contact = contact
    mail(to: ENV['EMAIL_FROM'], subject: subject)
  end
end
