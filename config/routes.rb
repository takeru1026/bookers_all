Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  root to: 'homes#top'
  get '/home/about', to: 'homes#about'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す 
  get '/search' => 'search#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
