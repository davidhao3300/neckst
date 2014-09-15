Rails.application.routes.draw do
  root 'public#home'

  namespace :api do
    resources :events, only: [:index]
  end
end
