Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :credit_cards, except: :show
  resources :purchases, except: :show do
    post 'create_payments', on: :member
  end
  resources :monthlies, except: :show
  resources :taxes, except: :show
  resources :payments, except: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
