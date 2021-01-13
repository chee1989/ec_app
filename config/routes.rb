Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions'
  }
  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end
  root 'homes#index'
  post '/', action: :create, controller: 'contacts'
  resources :categories
  post '/products/:id', action: :create, controller: 'products'
  resources :products, shallow: true do
    resources :favorites, only: [:create, :destroy]
    get :favorites, on: :collection
    resources :likes, only: [:create, :destroy]
  end

  namespace :admin do
    resources :users
    resources :logs
    resources :contacts
    resources :categories
    resources :products do
      post :confirm, action: :confirm_new, on: :new
      post :import, on: :collection
    end
    root 'homes#index'
  end

  scope '/api' do
    get '/products', to: 'products#index', defaults: { format: :json }
  end
end
