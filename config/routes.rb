Rails.application.routes.draw do
  resources :workspaces do
    resources :invitations
  end
  resource :session
  resources :passwords, param: :token
end
