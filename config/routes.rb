Rails.application.routes.draw do
  devise_for :employees
  devise_for :customers, :controllers => { registrations: 'registrations' }

  root "pages#index"

  get "/customers/dashboard" => "customers#show"
  get "/customers/Wholesaleapplication" => "customers#index"
  get "/employees/dashboard" => "employees#show"

  get "/about" => "pages#about"
  get "/coffee_club" => "pages#coffee_club"
  get "/coffee_house" => "pages#coffee_house"

  get "/menus/new" => "menus#new"
  post "/menus" => "menus#create"
  get "/menus/:id/edit" => "menus#edit"
  patch "/menus/:id" =>"menus#update"
  delete "/menus/:id" => "menus#destroy"

  get "/categories/new" => "categories#new"
  post "/categories" => "categories#create"
  get "/categories/:id/edit" => "categories#edit"
  patch "/categories/:id" =>"categories#update"
  delete "/categories/:id" => "categories#destroy"


  post "/cart" => "carted_products#create"
  get "/cart" => "carted_products#index"
  patch "/cart" => "carted_products#update"

  post "/carted_subscription" => "carted_subscriptions#create"

  get "/orders" => "orders#show"

  resources :products
  get "/subscriptions" =>"products#subscriptions"
  resources :charges

  namespace :api do
    get "/customers" => "customers#index"
    patch '/customers/:id' => "customers#update"

    get "/employees" => "employees#index"

    get "/products" => "products#index"

    patch "/carted_products/:id/:qnty" => "carted_products#update"
    delete "/carted_products/:id" => "carted_products#destroy"

    patch "/carted_subscriptions/:id/:qnty" => "carted_subscriptions#update"
    delete "/carted_subscriptions/:id" => "carted_subscriptions#destroy"
  end
end
