Rails.application.routes.draw do

  resources :users, except: [:index]
  resources :alerts, except: [:index]
  get '/stations/filter_by_line' => 'stations#filter_by_line'
  get '/stations/:id/updates' => 'stations#updates'

  post 'sessions'    => 'sessions#create'
  delete 'sessions'  => 'sessions#destroy'

  root "application#home"

end
