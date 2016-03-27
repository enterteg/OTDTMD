Rails.application.routes.draw do

  post 'update_form' => 'posts#update_form'
  delete 'destroy_photo/:id' => 'posts#destroy_photo', as: :destroy_photo
  
  get '/search' => 'public#search', as: :search
  post 'login' => 'session#create', as: :login
  get 'logout' => 'session#destroy', as: :logout
  get 'login' => 'session#new'
  get 'stats' => 'admin#stats', as: :stats

  resources :posts   
  get ':action' => 'public#action'

  root 'public#index'
end
