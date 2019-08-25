class Calculadora
  include ActiveModel::Model

  attr_accessor :rede_eletrica, :estado, :cidade, :local, :ajuste, :media
  attr_accessor :nome, :telefone, :email
  attr_accessor :pdf_name

  validates_presence_of :rede_eletrica, :estado, :cidade, :local, :ajuste, :media, if: :acesso_a_rede_eletrica?
  validates_presence_of :rede_eletrica, :nome, :telefone, :email, unless: :acesso_a_rede_eletrica?

  private

  def acesso_a_rede_eletrica?
    rede_eletrica == 'sim'
  end

end
