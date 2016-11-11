Rails.application.routes.draw do

  get 'users/index'

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
  get 'users', to: 'profiles#index', as: :users
  get 'users/:username', to: 'profiles#show', as: :profile
  get 'users/:username/edit', to: 'profiles#edit', as: :edit_profile
  patch 'users/:username/edit', to: 'profiles#update', as: :update_profile

  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  get 'browse', to: 'posts#browse', as: :browse_posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
