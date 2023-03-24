Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :wallet, only: [:create]
      resources :category, only: [:create, :update]
    end
  end
end
