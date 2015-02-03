Rails.application.routes.draw do

  resources :alerts, except: [:index, :new]
  get '/stations/filter_by_line' => 'stations#filter_by_line'
  get '/stations/:id/updates' => 'stations#updates'

  root "application#home"

end
