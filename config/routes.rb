Rails.application.routes.draw do

  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'notifications', to: 'notifications#index'

  root to: "posts#index" 
  resources :posts do
    resources :comments 
    member do
      get 'like' 
      get 'unlike'
    end
  end
  devise_for :users, controllers: { sessions: 'users/sessions' }

  #profile custom routes
  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile
  patch ':username/edit', to: 'profiles#update', as: :update_profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
