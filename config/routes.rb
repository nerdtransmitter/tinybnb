Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :homes do
    resources :listings, except: [:destroy]
  end
  resources :listings, only: [] do
    member do
      post :approve
    end
  end

  resources :listings, only: [:destroy, :edit, :update, :show]
end
