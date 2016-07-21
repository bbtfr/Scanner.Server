Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :news
  resource :audit, only: :show do
    get :identify
  end

  namespace :api, defaults: { format: 'json' } do
    resources :news, only: :index
    resource :identity, only: [] do
      post :identify
      get :abilities
      post :use_count
    end
  end
end
