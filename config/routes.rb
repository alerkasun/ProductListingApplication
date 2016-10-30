Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }  do
    scope module: :v1 do
      resources :products, only: [:create, :update, :destroy, :show, :index]
    end
  end

  root 'products#index'
  resources :products
end
