EmberTwitterApi::Application.routes.draw do
  get 'auth/twitter/callback', to: 'sessions#create'
  resource   :session
  namespace :twitter do
    resources :tweets, only: [:create]
    resources :timelines do
      get :home, on: :collection
    end
    resources :users, only: :show
  end

  get 'home' => 'home#index'
  #TODO: Move this under the :twitter namespace
  get 'user' => 'users#show'

  root  to:   'home#index'
end
