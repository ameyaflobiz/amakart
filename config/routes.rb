Rails.application.routes.draw do

  resources :users do

    member do
      post :get_otp
    end

    collection do
      post :login
    end

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
