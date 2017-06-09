Rails.application.routes.draw do
  devise_for :employees
  devise_for :customers
  get "/" => "pages#index"
  
end
