Rails.application.routes.draw do
  get 'pages/home'

  get 'pages/about'

  get 'pages/subscribe'

  resources :subscribers
  resources :comments
  resources :posts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
