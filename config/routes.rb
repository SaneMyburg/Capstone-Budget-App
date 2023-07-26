Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  authenticate :user do
    resources :categories, only: [:index, :new, :create] do
      resources :expenses, only: [:index, :new, :create]
    end
    delete '/sign_out', to: 'users/sessions#destroy', as: :sign_out
  end
end
