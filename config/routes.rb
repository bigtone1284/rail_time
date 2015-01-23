Rails.application.routes.draw do

  resources :users, except: [:index]
  resources :alerts, except: [:index]
  get '/stations/search' => 'stations#search'
  root "application#home"

end
