Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  get 'likes/create'
  get 'likes/destroy'
  get 'comments/create'
  get 'comments/show'
  get 'comments/edit'
  root to: 'posts#index'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  resources :users, only: %i[index] do
    resource :relationships, only: %i[create destroy], module: :users
  end

  resources :posts do
    resources :comments, module: :posts
    resource :like, only: %i[create, destroy], module: :posts
  end
end
