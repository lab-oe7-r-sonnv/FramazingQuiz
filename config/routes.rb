Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  mount ActionCable.server => "/cable"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :users do
      member do
        get :lessons, to: "lessons#index"
        get :notifications, to: "notifications#index"
      end
    end
    resources :lessons, except: :index do
      member do
        resource :flashcards, only: :new
        resource :writes, only: %i(new update)
      end
    end
    resources :pages, only: :show
    resources :notifications, only: :create
    root "pages#home", page: "home"
    get "*pages", to: "errors#routing"
  end
end
