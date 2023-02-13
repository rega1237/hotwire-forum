Rails.application.routes.draw do
  resources :categories
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"

  resources :discussions do
    resources :posts, only: [:create, :destroy, :show, :edit, :update], module: :discussions
  end
end
