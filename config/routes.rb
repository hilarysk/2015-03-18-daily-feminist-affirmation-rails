Dailyfemaff::Application.routes.draw do


  # NOTES:
  #
  # - Add so admins can see all of particular item (already exists in search, but still)
  # - Make it so admin layout menu includes public options; have so admin or public menu displays based on if someone is logged in.
  # - Design - more gray boxes, more hover with checkboxes, fewer dropdowns for display where possible
  # - Test that putting in bad info doesn't work and displays errors properly
  # - Make so when click submit buttons, partial 'display' changes instead of loading partial (cleaner, doesn't reload page) ---> ??
  # - Make so yay item.sample requires one database call instead of four
  # - Pull out the auto-keyword tagging into method
  # - responsive using @media/@screens / break points?

  ##################################################

  # PUBLIC

  root :to => 'public#yay'
  get "whoops" => 'public#whoops'
  get "about" => 'public#about'
  get "search" => 'public#search'
  get "keyword" => 'public#keyword'
  get "item" => 'public#item'

  ##################################################

  # ADMIN GENERAL

  get "admin/inactive" => 'admin#inactive'
  get "login" => 'admin#login'
  post "login" => 'application#user_verify'
  get "logout" => 'application#logout'
  get "admin/contrib" => 'admin#contrib'
  get "admin/update_library" => 'admin#update_library' # --> change to "library" instead of "database"

  ##################################################

  # ADMIN EXCERPT
  get "admin/excerpts/new" => 'excerpts#new'
  post "admin/excerpts" => 'excerpts#create', as: "excerpts"
  get "admin/excerpts/update" => 'excerpts#update_find'
  post "admin/excerpts/update_choice" => 'excerpts#update_choice'
  get "admin/excerpts/:id/edit" => 'excerpts#edit'
  put "admin/excerpts/:id" => 'excerpts#update'
  get "admin/excerpts/delete" => 'excerpts#delete_find'
  post "admin/excerpts/delete_choice" => 'excerpts#delete_choice'
  get "admin/excerpts/:id/delete" => 'excerpts#deleteconfirm'
  delete "admin/excerpts/:id" => 'excerpts#delete'

  ##################################################

  # ADMIN QUOTE
  get "admin/quotes/new" => 'quotes#new'
  post "admin/quotes" => 'quotes#create', as: "quotes"
  get "admin/quotes/update" => 'quotes#update_find'
  post "admin/quotes/update_choice" => 'quotes#update_choice'
  get "admin/quotes/:id/edit" => 'quotes#edit'
  put "admin/quotes/:id" => 'quotes#update'
  get "admin/quotes/delete" => 'quotes#delete_find'
  post "admin/quotes/delete_choice" => 'quotes#delete_choice'
  get "admin/quotes/:id/delete" => 'quotes#deleteconfirm'
  delete "admin/quotes/:id" => 'quotes#delete'

  ##################################################

  # ADMIN TERM

  # This shows the form to create a new term

  get "admin/terms/new" => 'terms#new'
  post "admin/terms" => 'terms#create', as: "terms"
  get "admin/terms/update" => 'terms#update_find'
  post "admin/terms/update_choice" => 'terms#update_choice'
  get "admin/terms/:id/edit" => 'terms#edit'
  put "admin/terms/:id" => 'terms#update'
  get "admin/terms/delete" => 'terms#delete_find'
  post "admin/terms/delete_choice" => 'terms#delete_choice'
  get "admin/terms/:id/delete" => 'terms#deleteconfirm'
  delete "admin/terms/:id" => 'terms#delete'

  ##################################################

  # ADMIN PERSON
  get "admin/people/new" => 'people#new'
  post "admin/people" => 'people#create', as: "people"
  get "admin/people/update" => 'people#update_find'
  post "admin/people/update_choice" => 'people#update_choice'
  get "admin/people/:id/edit" => 'people#edit'
  put "admin/people/:id" => 'people#update'
  get "admin/people/delete" => 'people#delete_find'
  post "admin/people/delete_choice" => 'people#delete_choice'
  get "admin/people/:id/delete" => 'people#deleteconfirm'
  delete "admin/people/:id" => 'people#delete'

  ##################################################

  # ADMIN KEYWORD
  get "admin/keywords/new" => 'keywords#new'
  post "admin/keywords" => 'keywords#create', as: "keywords"
  get "admin/keywords/update" => 'keywords#update_find'
  post "admin/keywords/update_choice" => 'keywords#update_choice'
  get "admin/keywords/:id/edit" => 'keywords#edit'
  put "admin/keywords/:id" => 'keywords#update'
  get "admin/keywords/delete" => 'keywords#delete_find'
  post "admin/keywords/delete_choice" => 'keywords#delete_choice'
  get "admin/keywords/:id/delete" => 'keywords#deleteconfirm'
  delete "admin/keywords/:id" => 'keywords#delete'

  ##################################################

  # # ADMIN KEYWORDITEM
  get "admin/tags/change" => 'keyword_items#choose'
  post "admin/tags" => 'keyword_items#change'

  ##################################################

  # ADMIN USER
  # MUST HAVE PRIVILEGE OF 1
  get "admin/users/new" => 'users#new'
  post "admin/users" => 'users#create', as: "users"
  get "admin/users/update" => 'users#update_find'
  post "admin/users/update_choice" => 'users#update_choice'
  # -----------------------------------------------
  get "admin/users/:id/edit" => 'users#edit'
  put "admin/users/:id" => 'users#update'  #include session check for this method so that only works if params["id"] matches session["user_id"]

  ################################################################2
  get "admin/users/delete" => 'users#delete_find'
  post "admin/users/delete_choice" => 'users#delete_choice'
  get "admin/users/:id/delete" => 'users#deleteconfirm'
  delete "admin/users/:id" => 'users#delete'

  ##################################################

  # MATCHES
  match "/admin/*path" => 'admin#coming_soon'
  match '*path' => 'public#whoops'

end
