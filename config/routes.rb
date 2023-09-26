Rails.application.routes.draw do


  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    resources :posts do
      resource :favorites, only: [:index, :create, :destroy]
      resources :post_comments, only: [:create]
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
