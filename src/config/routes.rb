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

  get "authenticated/home", to: "authenticated#home"
  get "authenticated/admin", to: "authenticated#admin"

  get "answer_form", to: "form#answer_form"
  post "submit_form", to: "form#submit_form"

  if Rails.env.test?
    post "/test_login", to: "test_sessions#create"
  end

=begin
  get "admin_templates/index", to: "admin_templates#index"
  get "admin_templates/list", to: "admin_templates#list"
  get "admin_templates/new", to: "admin_templates#new"
=end

  resources :admin_templates do
    collection do
      get :list
      get :new
    end
  end

end
