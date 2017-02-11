Rails.application.routes.draw do
  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users, controller: 'clearance/users', only: [:create] do
    resource :password,
             controller: 'clearance/passwords',
             only: [:create, :edit, :update]
  end

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'clearance/users#new', as: 'sign_up'

  resources :pages, only: [:new, :index]

  root to: 'pages#index'

  constraints Clearance::Constraints::SignedIn.new do
    root to: 'pages#new'
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'pages#index'
  end
end
