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

  MEDIA_DIAS_POR_MES   = 30
  MEDIA_HORAS_BRASIL   = 5
  MEDIA_MINIMA         = 3800
  MEDIA_MAXIMA         = 4500
  NUMERO_MESES_ANO     = 12
  NUMERO_MESES_25_ANOS = NUMERO_MESES_ANO * 25
  POTENCIA_MEDIA_PLACA = 330
  EFICIENCIA_PAINEL    = 0.83

  def self.human_attribute_name(attr, options = {}) # 'options' wasn't available in Rails 3, and prior versions.
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def kwp
    kw = (media.to_f / ajuste_ou_default.to_f).round(2)

    step_1 = kw.to_f / MEDIA_DIAS_POR_MES.to_f
    step_2 = step_1.to_f / MEDIA_HORAS_BRASIL.to_f
    step_3 = step_2 / EFICIENCIA_PAINEL

    step_3.round(2)
  end

  def ajuste_ou_default
    ajuste.nil? ? get_taxa_sem_ajuste : ajuste.to_f
  end

  def investimento_minimo
    kwp * MEDIA_MINIMA
  end

  def investimento_maximo
    kwp * MEDIA_MAXIMA
  end

  def media_aritmetica
    (investimento_minimo + investimento_maximo) / 2
  end

  def economia_mensal
    media.to_f
  end

  def economia_anual
    economia_mensal * NUMERO_MESES_ANO
  end

  def economia_25_anos
    economia_mensal * NUMERO_MESES_25_ANOS
  end

  def retorno
    (media_aritmetica / economia_mensal) / NUMERO_MESES_ANO
  end

  def cidade_nome
    city_repository.find(cidade).name
  end

  def qtd_paineis
    ((kwp / POTENCIA_MEDIA_PLACA * 1000)).round
  end

  def geracao_media
    (economia_mensal / ajuste_ou_default.to_f).to_i
  end

  private

  def acesso_a_rede_eletrica?
    rede_eletrica == 'sim'
  end

  def get_taxa_sem_ajuste
    state = state_repository.find(estado)

    case local
    when 'residencial'
      state.residencial
    when 'comercial'
      state.comercial
    when 'outro'
      state.outro
    else
      state.residencial
    end

  end

  def city_repository
    City
  end

  def state_repository
    State
  end
end
