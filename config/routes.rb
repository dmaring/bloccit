Rails.application.routes.draw do

# we pass resources :posts to the resources :topics block. This nests the post routes under the topic routes.
  resources :topics do
    # creates all routes for :posts except for the index route
    resources :posts, except: [:index]
  end

  # we use only: [] because we don't want to create any  /posts/:id routes, just posts/:post_id/comments routes
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  resources :users, only: [:new, :create, :show]


  resources :sessions, only: [:new, :create, :destroy]


  # Allows users to visit /about rather than /welcome/about
  get 'about' => 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
