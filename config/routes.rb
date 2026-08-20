Rails.application.routes.draw do
  resources :library_users
  root "biblioteca#index"

  get "esqueci_senha", to: "sessoes#esqueci_senha"
post "esqueci_senha", to: "sessoes#enviar_recuperacao"
  get "login", to: "sessoes#new"
  post "login", to: "sessoes#create"
  delete "logout", to: "sessoes#destroy"
  get "primeiro_acesso/:id", to: "librarians#primeiro_acesso", as: "primeiro_acesso"
patch "primeiro_acesso/:id", to: "librarians#atualizar_senha", as: "atualizar_senha"


  resources :categories
  resources :books
  resources :librarians
  resources :books do
  resources :loans, only: [:new, :create]
end

resources :loans, only: [:index] do
  member do
    patch :return_book
  end
end

  get "up" => "rails/health#show", as: :rails_health_check
end