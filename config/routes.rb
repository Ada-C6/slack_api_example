Rails.application.routes.draw do

  resources :homepages, only: [:index,  :create]
  root to: 'homepages#index'
  get '/new/:channel/:id' => 'homepages#new', as: 'new_message'
end
