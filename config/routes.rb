Rails.application.routes.draw do

  # Creates all CRUD routes for resource advertisements
  resources(:advertisements)

  # Creates all CRUD routes for resource posts
  resources :posts

  # Allows users to visit /about rather than /welcome/about
  get 'about' => 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
