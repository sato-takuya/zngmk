Rails.application.routes.draw do
  root 'pages#index'
  resources :posts,except: [:index]
  resources :pages
  get '/confirm/:id', to: 'posts#confirm', as: :confirm
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
