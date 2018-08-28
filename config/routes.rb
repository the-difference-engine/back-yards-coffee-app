Rails.application.routes.draw do
  devise_for :employees
  devise_for :customers, controllers: { registrations: 'registrations' }

  root to: 'pages#index'
  get '/customers' => 'customers#index'

  resources :editables
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
  get '/contact' => 'pages#contact'
  get '/faqs' => 'pages#faqs'

  get '/menu' => 'pages#menu'
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

  get '/cart', to: 'carted_products#index'
  patch '/cart', to: 'carted_products#update_address', as: 'cart_update_address'

  resources :carted_subscriptions, only: [:index, :create, :edit, :update, :destroy]
  resources :carted_products, only: [:index, :create, :update]

  get '/orders/new/' => 'orders#new'
  get '/orders/new:order_id' => 'orders#create'
  patch '/orders/:order_id/:shipping_id' => 'orders#update'
  get '/orders/show/:id' => 'orders#show'
  get '/orders/create' => 'orders#create', as: 'orders_create'

  # get '/subscriptions/new' => 'subscriptions#new'

  resources :products
  get '/subscriptions' => 'products#subscriptions'
  resources :charges

  namespace :api do
    get '/customers' => 'customers#index'
    patch '/customers/:id' => 'customers#update'

    get '/employees' => 'employees#index'



    get '/products' => 'products#index'

    get '/subscriptions' => 'subscriptions#index'
    post '/subscriptions' => 'subscriptions#create'

    patch '/carted_products/:id/' => 'carted_products#update'
    delete '/carted_products/:id' => 'carted_products#destroy'

    patch '/carted_subscriptions' => 'carted_subscriptions#update'
  end
end
