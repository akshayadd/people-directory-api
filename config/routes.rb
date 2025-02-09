Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :peoples do
    collection do
      delete :destroy_multiple
    end
    member do
      post :restore
    end
    resources :phone_numbers, only: [:create, :update, :destroy]
    resources :emails, only: [:create, :update, :destroy]
    resources :addresses, only: [:create, :update, :destroy]
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
