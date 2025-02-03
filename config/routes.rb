Rails.application.routes.draw do
  namespace :admin do
      resources :products

      root to: "products#index"
    end
  resources :products
  root "products#index"
end
