Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions'
  }
  get 'users/edit'
  get 'users/show'
  root 'homes#index'
  post '/', action: :create, controller: 'contacts'

  namespace :admin do
    resources :users
    resources :logs
    resources :contacts
    resources :categories
    resources :products
    root 'homes#index'
  end
end
