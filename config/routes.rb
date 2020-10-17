Rails.application.routes.draw do
  root 'communities#index'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :communities do
    resources :posts do
      resources :likes, only: %i[create destroy]
      resources :comments
    end
    resources :applies, only: %i[index create destroy]
    resources :belongings, only: %i[index create destroy]
  end

  resources :users, only: %i[index show] do
    member do
      get :follower, :followed
    end
  end

  post 'follow/:id' => 'relationships#create', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow' # フォロー外す

end
