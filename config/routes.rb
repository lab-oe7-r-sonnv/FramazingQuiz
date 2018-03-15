Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  mount ActionCable.server => "/cable"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :users do
      member do
        get :lessons, to: "lessons#index"
        get :notifications, to: "notifications#index"
        get :bookmarked_lessons, to: "bookmarked_lessons#index"
      end
    end
    resources :lessons, except: :index do
      member do
        resource :notifications, only: :create
        resource :bookmarked_lessons, only: %i(create destroy)
        resource :flashcards, only: :new
        resource :writes, only: %i(new update)
      end
    end
    resources :pages, only: :show
    root "pages#home", page: "home"
    get "*pages", to: "errors#routing"
  end
end
