Rails.application.routes.draw do
  resources :workspaces
  resource :session
  resources :passwords, param: :token
end
