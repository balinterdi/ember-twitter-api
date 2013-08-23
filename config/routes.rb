EmberTwitterApi::Application.routes.draw do
  get 'auth/twitter/callback', to: 'sessions#create'
  resource   :session
  namespace :twitter do
    resources :timelines do
      get :home, on: :collection
    end
    resource :user, only: :show
  end

  resources  :users, only: :create

  get 'home' => 'home#index'

  root  to:   'home#index'
end
