Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions'
  }
  get 'users/edit'
  get 'users/show'
  root 'homes#index'

  namespace :admin do
    resources :users
    resources :logs
    root 'homes#index'
  end
end
