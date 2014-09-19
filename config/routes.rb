Caraten::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :contacts, path: 'kontakt', only: [:index, :create]
  resources :members, path: 'medlemmar', only: [:index] do
    put :update_multiple, on: :collection
  end
  # resources :users, path: 'installningar', only: [:index, :update]
  resources :news, path: 'nyheter' do
    post :comment, on: :member
  end
  resources :topic, path: 'diskussioner' do
    post :comment, on: :member
  end
  resources :texts, only: [] do
    post :update, on: :collection
  end

  resources :events, path: 'kalender'
  resources :letters, path: 'brev' do
    post :send_me, on: :member
    post :send_all, on: :member
  end

  resources :uploads, only: :create

  root :to => 'home#index'

  get '*slug', to: 'pages#show', constraints: PageExistsConstraint.new
end
