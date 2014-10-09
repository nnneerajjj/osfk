Caraten::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }

  get 'inaktiv', to: 'home#inactive', as: 'inactive_registration'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount RailsAdminImport::Engine => '/rails_admin_import', :as => 'rails_admin_import'

  resources :contacts, path: 'kontakt', only: [:index, :create]
  resources :members, path: 'medlemmar' do
    put :update_multiple, on: :collection
  end
  # resources :users, path: 'installningar', only: [:index, :update]
  resources :news, path: 'nyheter' do
    post :comment, on: :member
    post :create_letter, on: :member
  end
  resources :topic, path: 'diskussioner' do
    post :comment, on: :member
  end
  resources :texts, only: [] do
    post :update, on: :collection
  end

  resources :events, path: 'kalender' do
    post :participate, on: :member
  end

  resources :letters, path: 'brev' do
    post :send_me, on: :member
    post :send_all, on: :member
  end

  resources :slides

  resources :pages, only: [:new, :create, :update]

  resources :uploads, only: :create

  root :to => 'home#index'

  get '*slug', to: 'pages#show', constraints: PageExistsConstraint.new
end
