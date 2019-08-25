Rails.application.routes.draw do
  root 'calculadora#new'

  get  'como-funciona', to: 'home#comofunciona'
  get  'orcamento',     to: 'home#orcamento'
  get  'a-empresa',     to: 'home#aempresa'

  resources :contacts,     only: [:new, :create]
  resources :calculadora, only: [:new, :create]

  get  'resultado',    to: 'calculadora#resultado'
  get  'download_pdf', to: 'calculadora#download_pdf'
  post 'resultado',    to: 'calculadora#resultado'

  get 'cities_by_state', to: 'cities#cities_by_state'
  get 'state_by_city',   to: 'states#state_by_city'
end
