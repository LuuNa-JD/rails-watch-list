Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  post 'home/create_review', to: 'home#create_review', as: 'create_review'
  get 'lists', to: 'lists#index'
  get 'lists/new', to: 'lists#new', as: "new_list"
  get 'lists/:id', to: 'lists#show', as: "list"
  post 'lists', to: 'lists#create'

  resources :lists do
    resources :bookmarks, only: [:new, :create, :destroy]
  end
end
