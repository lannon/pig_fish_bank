PigFishBank::Application.routes.draw do
  get 'dashboard' => 'pages#dashboard', :as => 'dashboard'

  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'login' => 'sessions#new', :as => 'login'
  resources :sessions, :deposits, :balance_inquiries, :withdrawals, :transfers

  root :to => 'pages#dashboard'
end
