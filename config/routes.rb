Rails.application.routes.draw do
  get 'pages/home'
  get 'home', to: 'pages#home'

  get 'pages/about'
  get 'about', to: 'pages#about'

  # Todo: This static page is unnecessary.
  get 'pages/subscribe'
  get 'subscribe', to: 'pages#subscribe'

  resources :subscribers do
    get 'unsubscribe', on: :member
  end
  resources :posts do
    resources :comments
  end
  resources :users

  root 'pages#home'
end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
