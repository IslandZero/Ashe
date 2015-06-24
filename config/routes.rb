Rails.application.routes.draw do
  root 'welcome#index'

  resources :bundles, only: [:show]
  resources :builds , only: [:new, :create, :show]
  resources :devices, only: [:new, :create, :show, :index] do
    post :create_mobileconfig, on: :collection
  end

  get   'admin'         => 'admin#index'
  post  'admin/enable'  => 'admin#enable'
  post  'admin/disable' => 'admin#disable'
end
