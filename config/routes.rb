Rails.application.routes.draw do
  resources :projects
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :articles do
    resources :comments
  end
  root 'welcome#index'
end
