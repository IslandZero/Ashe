Rails.application.routes.draw do
  root 'welcome#index'

  resources :bundles, only: [:show]
  resources :builds , only: [:new, :create, :show]
end
