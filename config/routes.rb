Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items, only: [:index] do
    member do
      get :add_to_basket
    end
  end

  resources :order_items, only: [:index, :edit, :update]

  resource :basket, only: [:destroy]

  root 'items#index'
end
