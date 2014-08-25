Caraten::Application.routes.draw do
  mount Rich::Engine => '/rich', :as => 'rich'

  devise_for :users do
    get "/skapakonto" => "devise/registrations#new", as: :new_user_registration
    post "/skapakonto" => "devise/registrations#create", as: :user_registration
  end

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :contacts, path: 'kontakt', only: [:index, :create]
  resources :members, path: 'medlemmar', only: [:index]
  resources :users, path: 'installningar', only: [:index, :update]
  resources :news, path: 'nyheter', only: [:index, :show] do
    post :comment, on: :member
  end
  resources :topic, path: 'forum' do
    post :comment, on: :member
  end

  root :to => 'home#index'

  #get '*id' => 'pages#show'
end
