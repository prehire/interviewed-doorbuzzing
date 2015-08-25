Rails.application.routes.draw do

    Rails.application.routes.draw do
      devise_for :users, controllers: {
        sessions: 'sessions',
      }
    end

	root to: 'front#index'
  match 'check_compatibility', to: 'front#check_compatibility', via: [:get, :post]

  # Auhenticated users
  resource :door, only: [:show, :update] do
    get :welcome
    post :assign_number
  end

	resources :schedules, except: [:edit]
	resources :codes, except: [:edit]
	resources :destinations, except: [:edit]

  namespace :twilio, :defaults => { :format => 'xml' } do
    match :receive_call, via: [:get, :post]
    match :enter_code, via: [:get, :post]
    match :dial_user_callback, via: [:get, :post]
    match :check_compatibility, via: [:get, :post]
  end
  
end
