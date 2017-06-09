Rails.application.routes.draw do
  devise_for :customers
  get "/" => "pages#index"
  
end
