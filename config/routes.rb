Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :executions, only: [:create]
  resources :pages, only: [:create, :show]
  resources :steps, only: [:create, :destroy]
  resources :tasks, only: [:index, :show, :create, :destroy]
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
