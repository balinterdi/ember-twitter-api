EmberTwitterApi::Application.routes.draw do
  get 'auth/twitter/callback', to: 'sessions#create'
  resource   :session #TODO: this should probably be a singleton
  resources  :timelines, only: :show
  resources  :users

  get 'home' => 'home#index'

  root  to:   'home#index'
end
