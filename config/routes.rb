Rails.application.routes.draw do
  root 'pages#index'
  resources :posts,except: [:index]
  resources :pages,param: :nickname
  get '/confirm/:id', to: 'posts#confirm', as: :confirm
  get '/posts/:id/element', to:'posts#element',as: :element
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
