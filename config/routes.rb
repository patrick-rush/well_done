Rails.application.routes.draw do
  # root 'application#home'

  resources :tasks
  resources :projects
  devise_for :users
  resources :users

  unauthenticated do
    root 'application#home', as: 'unauthenticated_user_root'
  end
 
  authenticated do
    root 'projects#index', as: 'authenticated_user_root'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# When models/controllers have been created, complete this task so that devise gem works correctly
# 2. Ensure you have defined root_url to *something* in your config/routes.rb.
# For example:

#   root to: "home#index"

# * Not required for API-only Applications *