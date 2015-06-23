Rails.application.routes.draw do
  root 'welcome#index'

  resources :bundles, only: [:show]
  resources :builds , only: [:new, :create, :show]
  resources :devices, only: [:new, :create, :show] do
    post :create_mobileconfig, on: :collection
  end
end
