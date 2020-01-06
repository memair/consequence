Rails.application.routes.draw do
  resources :goals
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get "/auth/:action/callback", controller: "authentications", constraints: { action: /memair|twitter/ }
  end

  root to: "home#index"
end
