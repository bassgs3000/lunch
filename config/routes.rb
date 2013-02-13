Lunch::Application.routes.draw do
  devise_for :users

  resources :preferences
  resources :restaurants do
    collection do
      post "evaluate"
    end
    member do
      post "like"
      post "dislike"
    end
  end

  root to: 'restaurants#index'
end
