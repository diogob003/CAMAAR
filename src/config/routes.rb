Rails.application.routes.draw do
  get "admin_templates/index"
  get "admin_templates/list"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "login#index"
  get "login", to: "login#index"
  post "login", to: "login#login"
  delete "logout", to: "login#logout"

  get "form", to: "form#index"

  get "authenticated/home", to: "authenticated#home"
  get "authenticated/admin", to: "authenticated#admin"

  get "answer_form", to: "form#answer_form"
  post "submit_form", to: "form#submit_form"

  get "list_forms", to: "form#list"
  get "edit_form", to: "form#edit_form"
  get "new_form", to: "form#new_form"
  get "form_results", to: "form#results"
  post "send_form", to: "form#send_form"
  delete "delete_form", to: "form#destroy"

  post "download_result", to: "form#download_result"

  resources :admin_templates, only: [ :index, :new, :create, :edit, :update, :destroy ] do
    collection do
      get :list
      get :new
    end
  end
end
