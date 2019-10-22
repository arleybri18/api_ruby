Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :api, defaults: { format: :json } do
    scope :v1, defaults: { format: :json } do
      resources :executions
      resources :pages
      resources :steps
      resources :tasks
      devise_for :users
    end
  end

end
