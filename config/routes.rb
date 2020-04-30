Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, only: [:create]
  end

  resources :users, only: [:show]

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

end
