Rails.application.routes.draw do
  resources :categories
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"

  resources :discussions do
    resources :posts, only: [:create, :destroy, :show, :edit, :update], module: :discussions do
      resources :replies, only: [:create, :update, :edit, :destroy], module: :posts
    end

    collection do
      get "categories/:id", to: "categories/discussions#index", as: "categories"
    end
  end

  resources :notifications do
    collection do
      put :mark_as_read
    end
  end
end
