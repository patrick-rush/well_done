Rails.application.routes.draw do
  root 'application#home'
  
  resources :tasks
  resources :projects
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# When models/controllers have been created, complete this task so that devise gem works correctly
# 2. Ensure you have defined root_url to *something* in your config/routes.rb.
# For example:

#   root to: "home#index"

# * Not required for API-only Applications *