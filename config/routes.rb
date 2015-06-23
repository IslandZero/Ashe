Rails.application.routes.draw do
  root 'welcome#index'

  get  'udid' => 'welcome#udid'
  post 'udid_callback' => 'welcome#udid_callback'

  resources :bundles, only: [:show]
  resources :builds , only: [:new, :create, :show]
end
