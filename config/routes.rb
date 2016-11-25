Rails.application.routes.draw do
  get 'order_items/update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items, only: [:index] do
    member do
      get :add_to_basket
    end
  end

  resource :basket, only: [:show, :edit, :update, :destroy]

  root 'items#index'
end
