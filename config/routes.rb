Rails.application.routes.draw do
  get 'collaborations/create'

  resources :wikis do
    member do
      get 'collaborations' 
    end
  end
  resources :collaborations
  resources :charges, only: [:new, :create]

   devise_for :users, :controllers => { :registrations => 'registrations' }
     resources :users, only: [:update,:show] do
      member do 
        get 'downgrade'
      end
    end
  root to: 'welcome#index'
  get 'about' =>'welcome#about'
  get 'collaborations' =>'wiki#collaborations'
end


