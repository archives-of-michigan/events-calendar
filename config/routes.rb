CivilWarEvents::Application.routes.draw do
  devise_for :users

  resources :categories, :constraints => { :id => /[^\/]*/ } do
    shallow do
      resources :events do
        member do
          put :approve
          put :unapprove
        end
      end
    end
    match 'calendars/:year/:month', :to => 'calendars#show'
    match 'events/:year/:month/:day', :to => 'events#by_day', :as => 'events_by_day'
  end

  root :to => 'categories#index'
  match 'teach', :to => 'root#teach'
  match 'events/:year/:month/:day', :to => 'root#teach_events_by_day', :as => 'teach_events_by_day'
  match 'calendars/:year/:month', :to => 'calendars#teach'
end
