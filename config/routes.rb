Rails.application.routes.draw do

  resources :users, except: [:index]
  resources :alerts, except: [:index]

  root "application#home"

end
