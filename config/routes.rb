Rails.application.routes.draw do

  resources :alerts, except: [:index, :new]

  get 'alerts/unsubscribe/:unsubscribe_hash' => 'alerts#unsubscribe', :as => 'unsubscribe'

  get '/stations/filter_by_line' => 'stations#filter_by_line'
  get '/stations/:id/updates' => 'stations#updates'

  root "application#home"

end
