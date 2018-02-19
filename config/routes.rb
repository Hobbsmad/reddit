Rails.application.routes.draw do
  devise_for :users
root "grams#index"
resources :grams do
  member do
    put 'upvote', to: 'grams#upvote'
    put 'downvote', to: 'grams#downvote'
    get :vote_up
  end
resources :comments, only: :create
  end
end
