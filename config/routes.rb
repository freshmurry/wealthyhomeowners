Rails.application.routes.draw do
   root "pages#home"		 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}
 		
   resources :users, only: [:show] do
     member do
       post '/verify_phone_number' => 'users#verify_phone_number'
       patch '/update_phone_number' => 'users#update_phone_number'
     end
   end

   resources :homes, except: [:edit, :destroy] do		
    member do		
       get 'listing'
       get 'pricing'
       get 'description'
       get 'photo_upload'
       get 'location'
       get 'preload'
       get 'preview'
       # get "about" => "pages#about" #creates about_path
    end
     resources :photos, only: [:create, :destroy]
     resources :reservations, only: [:create]
   #  resources :calendars
   end
  
   resources :guest_reviews, only: [:create, :destroy]
   resources :host_reviews, only: [:create, :destroy]
  		
   get '/past_spaces' => 'reservations#past_spaces'
   get '/your_reservations' => 'reservations#your_reservations'

   get 'search' => 'pages#search'

 # ---- AirKong ------
   get 'dashboard' => 'dashboards#index'

   resources :reservations, only: [:approve, :decline] do
     member do
       post '/approve' => "reservations#approve"
       post '/decline' => "reservations#decline"
     end
   end

   resources :revenues, only: [:index]

   resources :conversations, only: [:index, :create, :destroy]  do
     resources :messages, only: [:index, :create, :destroy]
   end

   # get '/host_calendar' => "calendars#host"
   # get '/payment' => "users#payment"
   # get '/payout' => "users#payout"
   # post '/add_card' => "users#add_card"

   get '/notification_settings' => 'settings#edit'
   post '/notification_settings' => 'settings#update'
   delete '/notification_settings' => 'settings#destroy'

   get '/notifications' => 'notifications#index'

   mount ActionCable.server => '/cable'
end