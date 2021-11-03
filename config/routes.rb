Rails.application.routes.draw do
  get 'users/:id', to: 'user#show', as: :user
  get '/', to: 'gossip#index', as: :index
  get 'welcome/:name', to: 'welcome#show', as: :welcome

  resources :gossip

  resources :contact, only: [:index]

  resources :team, only: [:index]

  resources :city, only: [:show]
  
  resources :gossip do
    resources :comments
  end
end
