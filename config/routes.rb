Rails.application.routes.draw do
  resources :rights
  get 'rights/fire/:id/:student_id' => 'rights#fire', as: :fire
  patch 'rights/assign/:assignment_id' => 'rights#assign_right', as: :assign_right

  devise_for :users
  resources :loans do
    member do
      get 'pay'
      post 'pay'
      get 'permissions'
      patch 'permissions'
    end

    collection do
      get 'all'
    end
  end
  resources :awards

  get 'transactions/index', as: :transactions
  post 'transactions/new', as: :new_transaction

  get 'welcome/home'
  root 'welcome#home'

  get 'dashboard/student'

  get 'dashboard/instructor'

  resources :students do
    collection do
      get 'send_money'
      post 'sent_money'
      post 'gave_bonus'
      get 'rankings'
    end
    member do
      get 'behavior'
      post 'reset'
    end
  end
  resources :jobs
  resources :periods do
    collection do
      post 'class_bonus'
    end
    member do
      get 'enter_behavior'
      patch 'update_behavior'
      get 'disable_accounts'
    end
  end
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
