Rails.application.routes.draw do
  root 'pages#index'
  get '/posts/:id/share', to:'posts#share',as: :share
  resources :posts,except: [:index]
  resources :pages,param: :nickname
  get '/confirm/:id', to: 'posts#confirm', as: :confirm
  get '/posts/:id/element', to:'posts#element',as: :element
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations"
  }
  devise_scope :user do
    delete '/users/:id' => 'users/registrations#destroy'
  end
end
