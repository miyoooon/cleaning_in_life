Rails.application.routes.draw do


  namespace :admin do
    resources :tags, only: [:new, :create, :index, :edit, :update, :destroy]
  end
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :edit, :update, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      member do
      get "favorites" => "favorites#index", as: "favorites"
      end
    end
    patch "/users/:id/withdraw" => "users#withdraw", as: "user_withdraw"
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
