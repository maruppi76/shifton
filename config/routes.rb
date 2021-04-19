Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}
  root "home#index"

  namespace :api, {format: 'json'} do
    resources :users, only:[:show] do
      collection do
        post "avatar"
        get "all_users"
        get "login_check"
        get "user_detail"
        get "dep_users"
      end
    end
    resources :shifts, only:[:create, :update, :destroy] do
      collection do
        get "all_shifts"
        get "my_shift"
        get "dep_shifts"
      end
    end
    resources :departments, only:[:index] do
    end
    resources :patterns, only:[:index] do
    end
    resources :types, only:[:index] do
    end
  end


  # 以下vue-router使用時にError発生を防ぐための記述
  get '/sign_in', to: 'home#index'
  get '/shifts/me',  to: 'home#index'
  get '/shifts/me_old',  to: 'home#index'
  get '/shifts/department',  to: 'home#index'
  get '/shifts/all',  to: 'home#index'
  get '/shifts/all/old',  to: 'home#index'
  get '/shift_preferred',  to: 'home#index'
  get '/staff_management',  to: 'home#index'
  get '/staff',  to: 'home#index'
  get '/staff/:id',  to: 'home#index'
  get '/shifts/create',  to: 'home#index'
end
