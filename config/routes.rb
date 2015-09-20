Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/edit'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :articles do
    resources :comments
  end
  root 'welcome#index'
end
