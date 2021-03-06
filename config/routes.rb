Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :users do
      member do
        get :lessons, to: "lessons#index"
        get :bookmarked_lessons, to: "bookmarked_lessons#index"
        resources :topics, param: :topic_id
      end
    end
    resources :lessons, except: :index do
      member do
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
