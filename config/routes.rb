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
    resources :products do
      post :confirm, action: :confirm_new, on: :new
    end
    root 'homes#index'
  end
end
