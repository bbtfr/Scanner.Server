Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :news
  resource :audit, only: [] do
    get :identify
    get :people

    get :show, to: redirect('/audit/identify')
  end

  namespace :api, defaults: { format: 'json' } do
    resources :news, only: :index
    resources :cities, only: :index
    resource :identity, only: [] do
      post :identify
      get :abilities
      post :use_count
    end
  end

  root to: 'news#index'
end
