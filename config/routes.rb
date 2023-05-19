Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :wallet, only: [:create, :show] do
        resources :wallet_transaction, only: [:create, :index]
      end
      resources :category, only: [:create, :update, :index]
      resources :wallet_transaction, only: [:update, :delete, :show]
    end
  end
end
