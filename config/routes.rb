Rails.application.routes.draw do
  root to: "home#index"

  # ユーザー登録／ログイン
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_log_in', to: 'users/sessions#guest_log_in'
  end

  # アカウント詳細ページ
  get 'users/account', to: 'accounts#show', as: 'user_account'

  # プロフィール
  get 'users/profile', to: 'profiles#show', as: 'user_profile'
  get 'users/profile/edit', to: 'profiles#edit', as: 'edit_user_profile'
  patch 'users/profile', to: 'profiles#update'

  # マイページ
  get 'mypage', to: 'mypage#index'

  # Songモデル
  resources :songs do
    resource :favorite, only: [:create, :destroy]
  end

  # Practiceモデル
  resources :practices
end
