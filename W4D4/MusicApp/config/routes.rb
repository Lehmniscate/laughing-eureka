Rails.application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resources :users, only: [:new, :create, :show]

  resources :bands, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :albums, only: [:new]
  end
  resources :albums, only: [:show, :create, :edit, :update, :destroy] do
    resources :tracks, only: [:new]
  end
  resources :tracks, only: [:show, :create, :edit, :update, :destroy]
end
