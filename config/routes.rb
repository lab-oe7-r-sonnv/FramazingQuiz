Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :users do
      member do
        get :lessons, to: "lessons#index"
      end
    end
    resources :lessons, except: :index
    resources :pages, only: :show
    root "pages#home", page: "home"
    get "*pages", to: "errors#routing"
  end
end
