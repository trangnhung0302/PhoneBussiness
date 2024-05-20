Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :admins do
      resources :auth do
        collection do
          get 'login', to: 'sessions#login'
          post 'login', to: 'sessions#create'
          post 'logout', to: 'sessions#destory'
          delete 'logout', to: 'sessions#destroy'
          post 'check_token', to: 'sessions#check_token'
        end
      end

      resources :staffs
      resources :customers
      resources :admins

      resources :reports do
        collection do
          get 'report_revenue', to: 'reports#report_revenue'
          get 'report_by_category', to: 'reports#report_by_category'
          get 'report_by_supplier', to: 'reports#report_by_supplier'
        end
      end
    end

    namespace :staffs do
      resources :auth do
        collection do
          get 'login', to: 'sessions#login'
          post 'login', to: 'sessions#create'
          post 'logout', to: 'sessions#destory'
          delete 'logout', to: 'sessions#destroy'
          post 'check_token', to: 'sessions#check_token'
        end
      end

      resources :categories
      resources :suppliers
      resources :items
      resources :orders
    end

    namespace :customers do
      resources :auth do
        collection do
          get 'login', to: 'sessions#login'
          post 'login', to: 'sessions#create'
          post 'logout', to: 'sessions#destory'
          delete 'logout', to: 'sessions#destroy'
          post 'check_token', to: 'sessions#check_token'
        end
      end

      resources :carts do
        collection do
          post 'update_carts', to: 'carts#update_carts'
        end
      end
      
      post 'account/register', to: 'account#register'
      get 'account/active_account/:token', to: 'account#active_account'
      get 'account/forgot_password', to: 'account#forgot_password'
      post 'account/reset_password', to: 'account#reset_password'

      resources :customer_destinations
      resources :payment_types
      resources :orders
      resources :order_cancel_reasons
      resources :reviews
    end

    resources :suppliers
    resources :items do
      collection do
        get :get_item_by_category_ids
      end
    end
    resources :categories
  end

  scope do
    root 'application#index'
    get '/*path', to: 'application#index'
  end
end
