Rails.application.routes.draw do
  devise_for :users

  use_doorkeeper do
    controllers applications: 'admin/apps'
    skip_controllers :authorized_applications, :token_info
  end

  namespace :api, path: 'api/1', defaults: { format: 'json' } do
    resources :reservations, only: [:create, :update, :show, :index] do
      resource :cancel, only: :create, controller: 'reservations/cancel'
    end
    resources :availabilities, only: [:show, :index]
  end

  namespace :admin do
    resources :users
    resources :companies
    resources :rates
    resources :airports
    resources :reservations, only: [:index, :show, :edit, :update] do
      get '/resend_confirmation_email', to: 'reservations#resend_confirmation_email', as: 'resend_confirmation_email'
      put :cancel, on: :member
    end
    namespace :payments do
      resources :owed, only: :index, controller: 'owed'
    end
    resources :payments

    namespace :import do
      resources :rates, only: [:index, :create]
    end

    namespace :reports do
      resources :companies, only: :index
      resources :reservations, only: :index
    end

    root 'welcome#index'
  end

  root 'admin/welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
