Rails.application.routes.draw do
  get '/tasks/completed' => 'tasks#completed'
  
  resources :tasks
  resources :projects do
    resources :tasks, only: [:new]
  end
  resources :friendships, only: [:new, :create, :destroy]
  resources :comments, only: [:create, :destroy]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show] do
    resources :projects, only: [:index]
  end

  authenticated :user do
    root 'projects#index', as: 'authenticated_root'
  end
  devise_scope :user do
    root 'devise/sessions#new'
  end



  # Example custom route
  # get '/posts/:id' => 'posts#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end