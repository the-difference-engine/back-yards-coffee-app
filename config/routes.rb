Rails.application.routes.draw do
  devise_for :employees
  devise_for :customers, controllers: { registrations: 'registrations' }

  root 'pages#index'
  get '/customers' => 'customers#index'

  get '/customers/dashboard' => 'customers#show'
  resources :customers, except: [:show]
  get '/employees/dashboard' => 'employees#show'

  get '/wholesalers' => 'wholesalers#index'
  get '/wholesalers/new' => 'wholesalers#new'
  post '/wholesalers' => 'wholesalers#create'
  get 'wholesalers/:id' => 'wholesalers#show', as: 'wholesalers_show'
  get 'wholesalers/:id/edit' => 'wholesalers#edit'
  patch 'wholesalers/:id' => 'wholesalers#update'

  get '/about' => 'pages#about'
  get '/coffee_club' => 'pages#coffee_club'
  get '/coffee_house' => 'pages#coffee_house'
  get '/contact' => 'pages#contact'
  get '/faqs' => 'pages#faqs'

  get '/menus/new' => 'menus#new'
  post '/menus' => 'menus#create'
  get '/menus/:id/edit' => 'menus#edit'
  patch '/menus/:id' => 'menus#update'
  delete '/menus/:id' => 'menus#destroy'

  get '/categories/new' => 'categories#new'
  post '/categories' => 'categories#create'
  get '/categories/:id/edit' => 'categories#edit'
  patch '/categories/:id' => 'categories#update'
  delete '/categories/:id' => 'categories#destroy'


  post '/cart' => 'carted_products#create'
  get '/cart' => 'carted_products#index'
  patch '/cart' => 'carted_products#update'

  post '/carted_subscription' => 'carted_subscriptions#create'

  resources :coupons

  get '/orders/new/' => 'orders#new'
  get '/orders/new:order_id' => 'orders#create'
  get '/orders/show/:id' => 'orders#show'
  patch '/orders' => 'orders#create', as: 'orders_create'

  get '/subscriptions/new' => 'subscriptions#new'

  resources :products
  get '/subscriptions' => 'products#subscriptions'
  resources :charges

  namespace :api do
    get '/customers' => 'customers#index'
    patch '/customers/:id' => 'customers#update'

    get '/employees' => 'employees#index'

    get '/coupons'=>'coupons#index'

    get '/products' => 'products#index'

    get '/subscriptions' => 'subscriptions#index'
    post '/subscriptions' => 'subscriptions#create'

    patch '/carted_products/:id/:qnty' => 'carted_products#update'
    delete '/carted_products/:id' => 'carted_products#destroy'

    patch '/carted_subscriptions/:id/:qnty' => 'carted_subscriptions#update'
    delete '/carted_subscriptions/:id' => 'carted_subscriptions#destroy'
  end
end
