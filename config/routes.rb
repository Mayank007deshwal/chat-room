Rails.application.routes.draw do
  # get 'rooms/create'
  resources :rooms, only: [:create, :show, :index, :destroy]
  devise_for :users
  get 'landing/index'
  # root 'landing#index'
  root 'rooms#index'
  resources :messages, only: [:new, :create, :destroy ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
