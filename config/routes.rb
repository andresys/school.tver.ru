TverSchool2::Application.routes.draw do
  devise_for :admins
  devise_for :users

  mount Ckeditor::Engine => '/ckeditor'
  namespace :root do
    root :to => "navigation#index"
    resources :admins
    resources :global_pages
    resources :schools do
      resources :users
    end
  end

  namespace :admin do
    # get 'school/:permalink', :controller => 'school', :action => 'show'
  	root :to => "school#index"
    resources :school do
      member do
        get 'contact'
        get 'sponsors'
      end
      resources :users
    	resources :static_pages
      resources :creations
      resources :announcements
      resources :sections
      resources :teachers
      resources :folders do
        resources :documents
      end
      resources :news
      resources :announce_to_parents
      resources :methodics
      resources :methodic_documents
      resources :media_links
      resources :page_groups
      post 'page_groups/navigation' => 'page_groups#navigation'
      resources :page_navigation_links
      resources :foods do
        collection do
          get 'findex', :controller => 'findex', :action => 'edit', as: :findex
          post 'findex', :controller => 'findex', :action => 'change'
          put 'findex', :controller => 'findex', :action => 'change'
        end
      end

      get ':link/:group/:id' => "static_pages#show"
      get ':group/:id' => "static_pages#show"
      get ':id' => "static_pages#show", constraints: { id: /[0-9]+/ }
    end
  end

  get 'school/:permalink', :controller => 'school', :action => 'show'
  resources :school do
    member do
      get 'contact'
    end
    resources :food
  	resources :static_pages
    resources :creation
    resources :announcement
    resources :section
    resources :teacher
    resources :news

    get 'folders'
    resources :documents

    resources :announce_to_parents
    resources :methodics
    resources :methodic_documents
    resources :media_links
    resources :sponsors

    resources :static_pages, path: '' do
      collection do
        get ':link', action: 'index', as: ''
        get ':link/:group/:id', :action => :show
        get ':group/:id', :action => :show
        get ':id', :action => :show
      end
    end
  end
  get '*path', :controller => 'global_pages', :action => :show

  root :to => "school#index"
end
