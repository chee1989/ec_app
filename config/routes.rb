Rails.application.routes.draw do
  devise_for :users
  get 'users/edit'
  get 'users/show'
  root 'homes#index'

  namespace :admin do
    resources :users
    root 'homes#index'
  end
end
