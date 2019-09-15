class Calculadora
  include ActiveModel::Model

  attr_accessor :rede_eletrica, :estado, :cidade, :local, :ajuste, :media
  attr_accessor :nome, :telefone, :email
  attr_accessor :pdf_name

  validates_presence_of :rede_eletrica, :estado, :cidade, :local, :ajuste, :media, if: :acesso_a_rede_eletrica?
  validates_presence_of :rede_eletrica, :nome, :telefone, :email, unless: :acesso_a_rede_eletrica?

  HUMANIZED_ATTRIBUTES = {
      local:  'Tipo do local da instalação',
      ajuste: 'Ajuste da tarifa',
      media:  'Energia por mês'
  }

  def self.human_attribute_name(attr, options = {}) # 'options' wasn't available in Rails 3, and prior versions.
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


  private

  def acesso_a_rede_eletrica?
    rede_eletrica == 'sim'
  end

end
