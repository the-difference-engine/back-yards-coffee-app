Rails.application.routes.draw do
  devise_for :employees
  devise_for :customers
  root "pages#index"

  get "/customers/dashboard" => "customers#show"

  get "/about" => "pages#about"
  get "/coffee_club" => "pages#coffee_club"
  get "/coffee_house" => "pages#coffee_house"

  post "/cart" => "carted_products#cart"
  
  resources :products
end
