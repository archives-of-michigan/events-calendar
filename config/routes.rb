CivilWarEvents::Application.routes.draw do
  devise_for :users

  resources :events do
    member do
      put :approve
      put :unapprove
    end
  end

  match '/calendars/:category/:year/:month', :to => 'calendars#show'
  match '/events/:category/:year/:month/:day', :to => 'events#by_day', :as => 'events_by_day'
  match '/events/:category', :to => 'events#index', :as => 'events'

  root :to => "events#index"
end
