Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "users/sign_up", to: "users/registrations#create"
    post "sign_in", to: "users/sessions#create"
  end
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
      resources :installment, only: [:destroy, :update, :show] do
        put :pay, on: :member
      end
    end
  end
end
