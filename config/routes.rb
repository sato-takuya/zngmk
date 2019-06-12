Rails.application.routes.draw do
  root 'pages#index'
  # confirmの追加
  get '/confirm/:id', to: 'posts#confirm', as: :confirm
  # only以下追記
  resources :posts
  # トップページにアクセスした際に postコントローラのnewアクションを呼び出す設定
  resources :pages
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
