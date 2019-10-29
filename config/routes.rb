Rails.application.routes.draw do
  resources :users
  resources :executions
  resources :pages
  resources :steps
  resources :tasks
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
