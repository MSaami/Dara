Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :wallet, only: [:create, :show] do
        resources :budget, only: [:create, :index]
        resources :wallet_transaction, only: [:create, :index]
        resources :loan, only: [:index, :create]
      end
      resources :category, only: [:create, :update, :index]
      resources :wallet_transaction, only: [:update, :destroy, :show]
      resources :budget, only: [:destroy, :update, :show]
      resources :loan do
        resources :installment, only: [:index]
      end
      resources :installment, only: [:destroy, :update] do
        put :pay, on: :member
      end
    end
  end
end
