Rails.application.routes.draw do
  resources :users
  resources :projects do
    resources :tasks
  end
  
  root "projects#index"
end
