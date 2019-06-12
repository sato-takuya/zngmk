Rails.application.routes.draw do
  root 'pages#index'
  resources :pages
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
