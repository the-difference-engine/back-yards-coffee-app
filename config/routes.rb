Rails.application.routes.draw do
  devise_for :employees
  devise_for :customers
  root "pages#index"

  get "/customers/dashboard" => "customers#show"
  get "/employees/dashboard" => "employees#show"

  get "/about" => "pages#about"
  get "/coffee_club" => "pages#coffee_club"
  get "/coffee_house" => "pages#coffee_house"

  post "/cart" => "carted_products#create"
  get "/cart" => "carted_products#index"
  patch "/cart" => "carted_products#update"

  resources :products
  get "/subscriptions" =>"products#subscriptions"
  resources :charges

  namespace :api do
    get "/customers" => "customers#index"

    get "/employees" => "employees#index"

    get "/products" => "products#index"
  end
end
