::Rails.application.routes.draw do

#  devise_for :users,  :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  match 'api' => 'api#api'

  #  scope :module => 'yuzublog' do
  resources :blogs, :module=> 'yuzublog' do # :controller => 'yuzublog/blogs' 
    member do
      get 'rsd'
      get 'wlwmanifest'
    end
  end
  # end
  resources :posts, :controller => 'yuzublog/posts'

  # If the domain looks like www.*, it's considered a "network" domain
  #constraints(NetworkDomainConstraint) do
  #  root :to => 'blogs#index' 
  #end

  match 'about', :to => 'home#about'
  match 'contact', :to => 'home#contact'

  # home#index will figure out if there's a blog associated with the hostname, and redirect to blogs#index if
  # it can't find an association.
 # root :to => 'home#index'
end
