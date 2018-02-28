Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :users do
      member do
        get :lessons, to: "lessons#index"
      end
    end
    resources :lessons, except: :index do
      member do
        resource :flashcards, only: :new
        resource :writes, only: %i(new edit)
      end
    end
    resources :pages, only: :show
    root "pages#home", page: "home"
    get "*pages", to: "errors#routing"
  end
end
