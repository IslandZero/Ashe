Rails.application.routes.draw do
  root 'welcome#index'

  resources :bundles, only: [:show]
  resources :builds , only: [:create, :show]
end
