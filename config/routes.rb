Rails.application.routes.draw do
  namespace :admin do
    resources :products do
      delete :image, on: :member, action: :destroy_image
    end
  end
  resources :products
  root "products#index"
end
