require 'sidekiq/web'

#Configure Sidekiq session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  mount Sidekiq::Web => '/sidekiq'

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  Rails.application.routes.draw do 
    namespace :api do
      namespace:v1 do 
        resources :users, param: :username
        post '/auth/login', to: 'authentication#login'
        
        #User Management Routes
        get '/users', to: 'users#index'
        post '/new_user', to: 'users#create'
        post '/edit_user', to: 'users#update'
        post '/delete_user', to: 'users#del_user'
        post '/verify_password', to: 'users#verify_password'
        post '/update_profile', to: 'users#update_profile'

        post '/custodian/new', to: 'custodian#create'
        get '/custodians', to: 'custodian#index'
        post '/custodian/edit', to: 'custodian#update'

        post '/devices/new', to: 'device#create'
        get '/devices', to: 'device#index'
        post '/device/edit', to: 'device#update'
        post 'devices/delete', to: 'device#void_devices'

        get '/events', to: 'event#index'
        get '/network_events', to: 'network_event#index'
        
      end
    end
  end
end
