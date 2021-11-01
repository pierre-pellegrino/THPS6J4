Rails.application.routes.draw do
  get 'users/:id', to: 'user#show', as: :user
  get 'gossips/:id', to: 'gossip#show', as: :gossip
  get '/', to: 'index#show', as: :index
  get 'welcome/:name', to: 'welcome#show', as: :welcome
  get 'contact/', to: 'contact#show'
  get 'team/', to: 'team#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
