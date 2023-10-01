Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/show'
  get 'comments/edit'
  root to: 'posts#index'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  resources :posts do
    resources :comments, module: :posts
  end
end
