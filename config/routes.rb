Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  namespace :admin do
    devise_for :users
    root 'homes#index'
  end
end
