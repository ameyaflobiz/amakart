Rails.application.routes.draw do

  resources :users do

    member do
      post :get_otp
    end

    collection do
      post :login
    end

  end

  resources :sellers do

    member do
      post :get_otp
    end

    collection do
      post :login
    end

  end

  resources :products do

    collection do 
      post :add_product
    end

  end

  resources :seller_products do

    collection do
      post :register_product
      put :update_product
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
