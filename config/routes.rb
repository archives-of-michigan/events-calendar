CivilWarEvents::Application.routes.draw do
  devise_for :users

  resources :events, :collection => { :calendar => :get }, 
    :member => { :approve => :put, :unapprove => :put }
  root :to => "events#index"
end
