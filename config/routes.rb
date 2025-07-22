Rails.application.routes.draw do
  root to: "home#index"

  # ユーザー登録／ログイン関連
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  # アカウント詳細ページ
  get 'users/account', to: 'accounts#show', as: 'user_account'

  # プロフィール関連
  get 'users/profile', to: 'profiles#show', as: 'user_profile'
  get 'users/profile/edit', to: 'profiles#edit', as: 'edit_user_profile'
  patch 'users/profile', to: 'profiles#update'

  # マイページ
  get 'mypage', to: 'mypage#index'

  # Songモデル関連
  resources :songs
end
