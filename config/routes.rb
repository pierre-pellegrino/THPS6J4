Rails.application.routes.draw do
  get '/', to: 'gossip#index', as: :index
  get 'welcome/:name', to: 'welcome#show', as: :welcome

  resources :users

  resources :gossip

  resources :sessions, only: [:new, :create, :destroy]

  resources :contact, only: [:index]

  resources :team, only: [:index]

  resources :city, only: [:show]

  resources :gossip do
    resources :comments
    resources :likes, only: [:new, :destroy]
  end
end
