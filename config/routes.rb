Rails.application.routes.draw do
  resources :comments
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :articles
  root 'welcome#index'
end
