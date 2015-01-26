Rails.application.routes.draw do

  resources :users, except: [:index]
  resources :alerts, except: [:index]
  get '/stations/filter_by_line' => 'stations#filter_by_line'
  get '/stations/:id/updates' => 'stations#updates'
  root "application#home"

end
