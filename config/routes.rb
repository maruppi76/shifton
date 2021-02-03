Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}
  root "home#index"

  namespace :api, {format: 'json'} do
    resources :users do
      collection do
        get "all_users"
        get "login_check"
        get "user_detail"
        get "dep_users"
      end
    end
    resources :shifts, only:[:create, :update] do
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
  get '/myshifts',  to: 'home#index'
  get '/departmentshifts',  to: 'home#index'
  get '/shifts',  to: 'home#index'
  get '/shift_preferred',  to: 'home#index'
  get '/staff_management',  to: 'home#index'
  get '/shifts/create',  to: 'home#index'
end
