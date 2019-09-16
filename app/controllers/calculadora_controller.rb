class CalculadoraController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @calculadora = Calculadora.new
    @calculadora.rede_eletrica = 'sim'
  end

  def resultado
    @calculadora = Calculadora.new(calculadora_params)

    if @calculadora.valid?
      if calculadora_params[:rede_eletrica] == 'sim'
        date     = Time.now.strftime('%d/%m/%Y')
        pdf_name = Time.now.to_i

        pdf_page01 = CombinePDF.load "#{Rails.root}/public/pdf/proposta_comercial_01.pdf"
        pdf_page02 = CombinePDF.load "#{Rails.root}/public/pdf/proposta_comercial_02.pdf"
        pdf_page03 = CombinePDF.load "#{Rails.root}/public/pdf/proposta_comercial_03.pdf"

        pdf_page01.pages[0].textbox "#{date}", height: 20, width: 70, y: 125, x: 490
        pdf_page02.pages[0].textbox "oioioioioiio", height: 20, width: 70, y: 596, x: 72

        pdf = CombinePDF.new
        pdf << pdf_page01
        pdf << pdf_page02
        pdf << pdf_page03

        pdf.save "#{Rails.root}/public/pdf/output#{pdf_name}.pdf"

        @pdf_name = pdf_name
      else
        @contact = Contact.new(calculadora_params)
        @contact.deliver
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:error] = 'Error'
      render action: 'new'
    end
  end

  def download_pdf
    pdf = CombinePDF.load "#{Rails.root}/public/pdf/output#{params[:pdf_name]}.pdf"

    send_data pdf.to_pdf, filename: 'orcamento.pdf', type: 'application/pdf'

    #File.delete("#{Rails.root}/public/pdf/output#{params[:pdf_name]}.pdf")
  end

  private

  def calculadora_params
    params.require(:calculadora).permit(:rede_eletrica, :estado, :cidade, :local, :ajuste, :media, :nome, :email, :telefone)
  end

end
