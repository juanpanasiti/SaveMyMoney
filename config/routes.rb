Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :credit_cards, except: :show
  resources :purchases, except: :show do
    post 'create_payments', on: :member
  end
  resources :monthlies, except: :show do
    member do
      get :new_payment
      post :create_payment
    end
  end
  resources :taxes, except: :show do
    member do
      get :new_payment
      post :create_payment
    end
  end
  resources :payments, except: :show do
    member do
      post 'pay'
      post 'unpay'
    end#member-do
  end#payments-do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
