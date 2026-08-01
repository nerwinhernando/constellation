Rails.application.routes.draw do
  root "home#index"
  resource :dashboard, only: :show, controller: "dashboard"

  resources :workspaces do
    resources :plans
    resources :invitations
  end

  resources :invitations, only: [] do
    member do
      get :accept
      post :complete
    end
  end

  resource :session
  resources :passwords, param: :token
end
