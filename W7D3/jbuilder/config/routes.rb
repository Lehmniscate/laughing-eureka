Rails.application.routes.draw do
 namespace :api, defaults: { format: :json } do
   resources :gifts, only: [:show]
   resources :guests, only: [:show, :index] do
     resources :gifts, only: [:index]
   end
   resources :invitations, only: [:show, :index]
   resources :parties, only: [:show, :index]
 end
end
