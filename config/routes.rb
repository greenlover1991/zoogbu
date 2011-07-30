Zoogbu::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'


  root :controller=> 'global', :action=>'index'
  



  namespace :admin do
    match '/animal/page/:page_no/sort/:sort_by', :controller=> 'animals', :action=>'index'
    match '/habitat_type/page/:page_no/sort/:sort_by', :controller=> 'habitat_types', :action=>'index'
    match '/status/page/:page_no/sort/:sort_by', :controller=> 'statuses', :action=>'index'
    match '/skill/page/:page_no/sort/:sort_by', :controller=> 'skills', :action=>'index'
    match '/employee/page/:page_no/sort/:sort_by', :controller=> 'employees', :action=>'index'
    match '/maintenance/page/:page_no/sort/:sort_by', :controller=> 'maintenances', :action=>'index'
    match '/food/page/:page_no/sort/:sort_by', :controller=> 'foods', :action=>'index'
    match '/event/page/:page_no/sort/:sort_by', :controller=> 'events', :action=>'index'
    match '/performance/page/:page_no/sort/:sort_by', :controller=> 'performances', :action=>'index'
    match '/subscriber/page/:page_no/sort/:sort_by', :controller=> 'subscribers', :action=>'index'
    match '/buyer/page/:page_no/sort/:sort_by', :controller=> 'buyers', :action=>'index'
    match '/sponsor/page/:page_no/sort/:sort_by', :controller=> 'sponsors', :action=>'index'
    match '/adoption/page/:page_no/sort/:sort_by', :controller=> 'adoptions', :action=>'index'
    match '/sponsorship/page/:page_no/sort/:sort_by', :controller=> 'sponsorships', :action=>'index'
    match '/user/page/:page_no/sort/:sort_by', :controller=> 'users', :action=>'index'
    match '/post/page/:page_no/sort/:sort_by', :controller=> 'posts', :action=>'index'
    match '/comment/page/:page_no/sort/:sort_by', :controller=> 'comments', :action=>'index'
    match '/zoomap/page/:page_no/sort/:sort_by', :controller=> 'zoomaps', :action=>'index'
    match '/map_area/page/:page_no/sort/:sort_by', :controller=> 'map_areas', :action=>'index'

    resources :habitat_types,:habitats, :animals, :statuses, :skills, :employees, 
	:maintenances, :foods, :events, :performances, :subscribers, :buyers, :sponsors, :adoptions, 
	:sponsorships, :users, :posts, :comments, :zoomaps, :map_areas
  end

  match '/admin/:action', :controller=>'admin/admin_main' 
  match '/admin', :controller=> 'admin/admin_main', :action => 'index'

  match '/:action', :controller => 'global'
  match '/index/page/:page_no', :controller=> 'global', :action=>'index'
  match '/zoogle/:action', :controller=> 'global'
  match '/zoogle/:action/:id', :controller=> 'global'
  match '/:action/:event_date', :controller => 'global'
  
  # last resort routes
  match ':controller/:action/:id'
  match ':controller/:action/:id.:format'

  
end
