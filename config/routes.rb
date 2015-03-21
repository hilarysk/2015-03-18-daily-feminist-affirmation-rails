Dailyfemaff::Application.routes.draw do
  
  ##################################################
  
  # PUBLIC
  
  root :to => 'public#home'
  
  get "home" => 'public#home'
  
  get "yay" => 'public#yay'
  
  get "whoops" => 'public#whoops' # <-- this refers to the controller, not the view
  
  get "about" => 'public#about'
  
  get "search" => 'public#search'
  
  get "keyword" => 'public#keyword'
  
  get "item" => 'public#item'
  
  ##################################################
  
  # ADMIN GENERAL
  
  get "login" => 'admin#login'
  
  post "login" => 'admin#user_verify'
  
  get "logout" => 'admin#logout'
  
  get "admin/contrib" => 'admin#contrib'
  
  get "admin/update_database" => 'admin#update_database' # --> change to "library" instead of "database"
  
  ##################################################
  
  # ADMIN EXCERPT
  
  # ---------> IF USING THE ADMIN IN FRONT FUCKS SHIT UP, YOU CAN DO THE RESOURCE :EXCERPTS WITH NAMESPACE OF ADMIN
  
  # This shows the form to create a new excerpt  
  
  get "admin/excerpts/new" => 'excerpts#new'
  
  # This saves the new excerpt; no route name.
  
  post "admin/excerpts" => 'excerpts#create', as: "excerpts"
  
  # This lets you choose which excerpt to edit.
  
  get "admin/excerpts/update" => 'excerpts#update_choice'
  
  # This shows the edit form for the excerpt.
  
  get "admin/excerpts/:id/edit" => 'excerpts#edit'
  
  # This updates the excerpt and saves the edit form data
  
  put "admin/excerpts/:id" => 'excerpts#update'
  
  # This deletes the excerpt.
  
  get "admin/excerpts/delete" => 'excerpts#delete_choice'
  
  delete "admin/excerpts/:id" => 'excerpts#delete'
  
  ##################################################
  
  # # ADMIN TERM
  #
  # # This shows the form to create a new term
  #
  # get "admin/terms/new" => 'terms#create'
  #
  # # This saves the new term; no route name.
  #
  # post "admin/terms" => 'terms#save'
  #
  # # This lets you choose which term to edit.
  #
  # get "admin/terms/update" => 'terms#update_choice'
  #
  # # This shows the edit form for the term.
  #
  # get "admin/terms/:id/edit" => 'terms#edit'
  #
  # # This updates the term and saves the edit form data
  #
  # put "admin/terms/:id" => 'terms#update'
  #
  # # This deletes the term.
  #
  # get "admin/terms/delete" => 'terms#delete_choice'
  #
  # delete "admin/terms/:id" => 'terms#delete'
  #
  # ##################################################
  #
  # # ADMIN QUOTE
  #
  # # This shows the form to create a new quote
  #
  # get "admin/quotes/new" => 'quotes#create'
  #
  # # This saves the new quote; no route name.
  #
  # post "admin/quotes" => 'quotes#save'
  #
  # # This lets you choose which quote to edit.
  #
  # get "admin/quotes/update" => 'quotes#update_choice'
  #
  # # This shows the edit form for the quote.
  #
  # get "admin/quotes/:id/edit" => 'quotes#edit'
  #
  # # This updates the quote and saves the edit form data
  #
  # put "admin/quotes/:id" => 'quotes#update'
  #
  # # This deletes the quote.
  #
  # get "admin/quotes/delete" => 'excerpts#quote_choice'
  #
  # delete "admin/quotes/:id" => 'quotes#delete'
  #
  # ##################################################
  #
  # # ADMIN PERSON
  #
  # # This shows the form to create a new person
  #
  # get "admin/people/new" => 'people#create'
  #
  # # This saves the new person; no route name.
  #
  # post "admin/people" => 'people#save'
  #
  # # This lets you choose which person to edit.
  #
  # get "admin/people/update" => 'people#update_choice'
  #
  # # This shows the edit form for the person.
  #
  # get "admin/people/:id/edit" => 'people#edit'
  #
  # # This updates the person and saves the edit form data
  #
  # put "admin/people/:id" => 'people#update'
  #
  # # This deletes the person.
  #
  # get "admin/people/delete" => 'people#delete_choice'
  #
  # delete "admin/people/:id" => 'people#delete'
  #
  # ##################################################
  #
  # # ADMIN USER
  #
  # # This shows the form to create a new user
  #
  # get "admin/users/new" => 'users#create'
  #
  # # This saves the new user; no route name.
  #
  # post "admin/users" => 'users#save'
  #
  # # This lets you choose which user to edit.
  #
  # get "admin/users/update" => 'users#update_choice'
  #
  # # This shows the edit form for the user.
  #
  # get "admin/users/:id/edit" => 'users#edit'
  #
  # # This updates the user and saves the edit form data
  #
  # put "admin/users/:id" => 'users#update'
  #
  # # This deletes the user.
  #
  # get "admin/users/delete" => 'users#delete_choice'
  #
  # delete "admin/users/:id" => 'users#delete'
  #
  # ##################################################
  #
  # # ADMIN KEYWORD
  #
  # # This shows the form to create a new keyword
  #
  # get "admin/keywords/new" => 'keywords#create'
  #
  # # This saves the new keyword; no route name.
  #
  # post "admin/keywords" => 'keywords#save'
  #
  # # This lets you choose which keyword to edit.
  #
  # get "admin/keywords/update" => 'keywords#update_choice'
  #
  # # This shows the edit form for the keyword.
  #
  # get "admin/keywords/:id/edit" => 'keywords#edit'
  #
  # # This updates the keyword and saves the edit form data
  #
  # get "admin/keywords/delete" => 'keywords#delete_choice'
  #
  # put "admin/keywords/:id" => 'keywords#update'
  #
  # ##################################################
  #
  # # ADMIN KEYWORD_ITEM
  #
  # # This shows the form to create a new keyword_item
  #
  # get "admin/keyword_items/new" => 'keyword_items#create'
  #
  # # This saves the new keyword_item; no route name.
  #
  # post "admin/keyword_items" => 'keyword_items#save'
  #
  # # This lets you choose which keyword_item to edit.
  #
  # get "admin/keyword_items/update" => 'keyword_items#update_choice'
  #
  # # This shows the edit form for the keyword_item.
  #
  # get "admin/keyword_items/:id/edit" => 'keyword_items#edit'
  #
  # # This updates the keyword_item and saves the edit form data
  #
  # put "admin/keyword_items/:id" => 'keyword_items#update'
  #
  # # This deletes the keyword_item.
  #
  # get "admin/keyword_items/delete" => 'keyword_items#delete_choice'
  #
  # delete "admin/keyword_items/:id" => 'keyword_items#delete'

  ##################################################
  
  # MATCHES
  
  match "/admin/*path" => 'admin#coming_soon'
  
  match '*path' => 'public#whoops'
  
  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
