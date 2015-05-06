Rails.application.routes.draw do
  resources :wikis
  resources :subscriptions
  resources :charges, only: [:new, :create]

   devise_for :users, :controllers => { :registrations => 'registrations' }
     resources :users, only: [:update,:show] do
      member do 
        get 'downgrade'
      end
    end
  root to: 'welcome#index'
  get 'about' =>'welcome#about'
end


