Rails.application.routes.draw do
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, format: 'json' do
    resources :tasks, only: [:index, :create, :destroy, :update]
  end

  mount ActionCable.server => '/cable'
end
