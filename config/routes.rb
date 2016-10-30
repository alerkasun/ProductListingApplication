Rails.application.routes.draw do
  scope path: '/api' do
    api_version(module: 'Api::V1',
                header: { name: 'Accept', value: 'application/vnd.product_listing.v1+json' },
                default: true) do

      resources :products, only: [:create, :update, :destroy, :show, :index]
    end
  end
  root :to => "products#index"
end
