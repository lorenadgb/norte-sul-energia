class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request

    if @contact.deliver!
      redirect_to new_contact_path, notice: 'OBRIGADO. ENTRAREMOS EM CONTATO EM BREVE!'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

end
