Ncaa::Application.routes.draw do
  get "charges/increase_pool_size"
  post "charges/pay_for_increase" => "charges#pay_for_increase", as: :charges_pay_for_increase
  get "cutoff_date/edit" => "cutoff_date#edit", as: :cutoff_date_edit
  put "cutoff_date/update" => "cutoff_date#update", as: :cutoff_date_update
  put "brackets/update_master" => "brackets#update_master", as: :brackets_update_master
  get "accountsettings/show"
  get "accountsettings/group_welcome"
  get "standings/show"
  #get "brackets/:user_id/edit" => "brackets#edit", as: :brackets_edit
  get "teams/edit" => "teams#edit", as: :teams_edit
  put "teams/update" => "teams#update", as: :teams_update
  get "brackets/edit" => "brackets#edit", as: :brackets_edit
  get "brackets/:user_id/view" => "brackets#view", as: :brackets_view
  get "brackets/edit_master" => "brackets#edit_master", as: :edit_master_bracket
  get "brackets/view_master" => "brackets#view_master", as: :view_master_bracket
	#patch "brackets/:id" => "brackets#update", as: :brackets_save
	resources :brackets
	resources :charges
  #devise_for :users
  devise_for :admins, :controllers => { :registrations => :registrations }
  devise_for :players, :controllers => { :registrations => :registrations }
  get "staticpages/index"
  get "staticpages/pricing"
  get "staticpages/scoring"
  get "staticpages/howitworks"
  get "staticpages/notauthorized"
  get "staticpages/nopairings"
  get "staticpages/signupthanks"
  get "staticpages/notpaid"
  get "staticpages/overmaxplayers"
  get "staticpages/nomoresignups"
  get "staticpages/contact"

  get "testpages/test"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'staticpages#index'

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
