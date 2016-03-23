Rails.application.routes.draw do

  post 'update_form' => 'posts#update_form'
  post 'login' => 'session#create', as: :login
  get 'logout' => 'session#destroy', as: :logout
  get 'login' => 'session#new'
  get 'stats' => 'public#stats', as: :stats
  resources :posts

  root 'public#index'
end
