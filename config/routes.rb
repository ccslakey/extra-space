Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'pages#landing_page'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks',
  }

  devise_scope :user do
    authenticated :user do
      root to: 'pages#dashboard', as: :authenticated_root
      resources :uploads
    end
    unauthenticated :user do
      root to: 'users/sessions#new'
    end
    patch '/users/confirmation' => 'users/confirmations#update'
  end
end
