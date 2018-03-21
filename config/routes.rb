Rails.application.routes.draw do


  # Creates all CRUD routes for resource posts and questions
  resources :posts
  resources :questions

  # Allows users to visit /about rather than /welcome/about
  get 'about' => 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
