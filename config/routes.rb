CivilWarEvents::Application.routes.draw do
  devise_for :users

  resources :events do
    member do
      put :approve
      put :unapprove
    end
  end

  match '/calendars/:year/:month', :to => 'calendars#show'

  root :to => "events#index"
end
