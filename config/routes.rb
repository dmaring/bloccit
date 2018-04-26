Rails.application.routes.draw do

# we pass resources :posts to the resources :topics block. This nests the post routes under the topic routes.
  resources :topics do
    # creates all routes for :posts except for the index route
    resources :posts, except: [:index]
  end

  resources :users, only: [:new, :create]
  post 'users/confirm', to: 'users#confirm'



  # Allows users to visit /about rather than /welcome/about
  get('about', to: 'welcome#about')

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
