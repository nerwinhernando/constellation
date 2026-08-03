Rails.application.routes.draw do
  root "home#index"
  resource :dashboard, only: :show, controller: "dashboard"

  resources :workspaces do
    resources :plans do
      resources :phases do
        resources :tasks do
          member do
            patch :complete
            patch :reopen
          end
        end
      end
    end
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
