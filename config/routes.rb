Translations::Application.routes.draw do
  devise_for :users
  resources :projects do
    member do
      get 'assign_chapters'
      get 'chapter_paragraphs/:chapter', action: :chapter_paragraphs, as: :chapter_paragraphs
      get 'assign_translators'
      get 'assign_reviewers'
      get :translate, :constraints => { :project_id => /\d/ }
    end
  end

  resources :users

  resources :translators

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
     namespace :admin do
       # Directs /admin/products/* to Admin::ProductsController
       # (app/controllers/admin/products_controller.rb)
       resources :projects
       get "/" => 'admin#index'
     end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'users#dashboard'

end
